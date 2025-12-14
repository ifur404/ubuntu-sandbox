#!/bin/bash
set -e

# Set root password from environment variable
echo "root:${SSH_PASSWORD:-changeme}" | chpasswd

# Create ssh keys directory in sandbox mount
mkdir -p /root/sandbox/.ssh-keys

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
echo "=========================================="

# Start SSH daemon in foreground
exec /usr/sbin/sshd -D
