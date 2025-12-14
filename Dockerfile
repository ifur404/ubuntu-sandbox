FROM ubuntu:24.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install essential tools and OpenSSH server
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    vim \
    curl \
    wget \
    git \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/sshd

# Install Node.js v24
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# SSH Configuration
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Configure SSH to use persistent host keys (remove default, add custom paths)
RUN sed -i '/^HostKey/d' /etc/ssh/sshd_config \
    && echo "" >> /etc/ssh/sshd_config \
    && echo "# Persistent host keys" >> /etc/ssh/sshd_config \
    && echo "HostKey /root/sandbox/.ssh-keys/ssh_host_rsa_key" >> /etc/ssh/sshd_config \
    && echo "HostKey /root/sandbox/.ssh-keys/ssh_host_ecdsa_key" >> /etc/ssh/sshd_config \
    && echo "HostKey /root/sandbox/.ssh-keys/ssh_host_ed25519_key" >> /etc/ssh/sshd_config
ENV NPM_CONFIG_PREFIX=/root/sandbox/.npm-global
ENV PATH="/root/sandbox/.npm-global/bin:$PATH"

# Create sandbox directory
RUN mkdir -p /root/sandbox

# Copy gemini-cli scripts to /opt (will be copied to persistent sandbox by entrypoint)
COPY gemini-cli /opt/gemini-cli
RUN chmod +x /opt/gemini-cli/*.sh

# Entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /root/sandbox

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
