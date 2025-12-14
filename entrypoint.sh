#!/bin/bash
set -e

# Set root password from environment variable
echo "root:${SSH_PASSWORD:-changeme}" | chpasswd

# Create persistent directories
mkdir -p /root/sandbox/.ssh-keys
mkdir -p /root/sandbox/.npm-global
mkdir -p /root/sandbox/.npm-cache
mkdir -p /root/sandbox/.gemini

# Copy gemini-cli scripts to persistent location if not exists
if [ ! -d /root/sandbox/gemini-cli ]; then
    echo "Copying gemini-cli scripts to persistent storage..."
    cp -r /opt/gemini-cli /root/sandbox/gemini-cli
fi

# Symlink Gemini CLI config to persistent location
if [ ! -L /root/.gemini ]; then
    rm -rf /root/.gemini
    ln -sf /root/sandbox/.gemini /root/.gemini
fi

# Configure npm to use persistent directories
npm config set prefix /root/sandbox/.npm-global
npm config set cache /root/sandbox/.npm-cache

# Add npm global bin to PATH in shell profile (for SSH sessions)
if ! grep -q "npm-global/bin" /root/.bashrc 2>/dev/null; then
    echo '' >> /root/.bashrc
    echo '# NPM Global Path' >> /root/.bashrc
    echo 'export PATH="/root/sandbox/.npm-global/bin:$PATH"' >> /root/.bashrc
fi

# Generate SSH host keys if they don't exist (persistent in sandbox)
if [ ! -f /root/sandbox/.ssh-keys/ssh_host_rsa_key ]; then
    echo "Generating SSH host keys..."
    ssh-keygen -t rsa -b 4096 -f /root/sandbox/.ssh-keys/ssh_host_rsa_key -N ""
    ssh-keygen -t ecdsa -b 521 -f /root/sandbox/.ssh-keys/ssh_host_ecdsa_key -N ""
    ssh-keygen -t ed25519 -f /root/sandbox/.ssh-keys/ssh_host_ed25519_key -N ""
fi

# Set proper permissions for host keys
chmod 600 /root/sandbox/.ssh-keys/ssh_host_*_key
chmod 644 /root/sandbox/.ssh-keys/ssh_host_*_key.pub

# Display connection info
echo "=========================================="
echo "Ubuntu Sandbox Container Started"
echo "=========================================="
echo "SSH Port: 22 (mapped to host 2222)"
echo "Ubuntu Version: $(cat /etc/lsb-release | grep DISTRIB_DESCRIPTION | cut -d'=' -f2 | tr -d '\"')"
echo "Node Version: $(node --version)"
echo "NPM Version: $(npm --version)"
echo "NPM Global: /root/sandbox/.npm-global"
echo "=========================================="

# Start SSH daemon in foreground
exec /usr/sbin/sshd -D
