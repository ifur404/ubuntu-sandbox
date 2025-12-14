FROM ubuntu:24.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install essential tools and OpenSSH server
RUN apt-get update && apt-get install -y \
    openssh-server \
    openssh-client \
    sudo \
    vim \
    nano \
    curl \
    wget \
    git \
    ca-certificates \
    gnupg \
    iputils-ping \
    net-tools \
    dnsutils \
    netcat-openbsd \
    htop \
    tree \
    jq \
    unzip \
    zip \
    tar \
    gzip \
    less \
    man-db \
    locales \
    tzdata \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    ripgrep \
    fd-find \
    tmux \
    screen \
    rsync \
    lsof \
    file \
    strace \
    procps \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/sshd \
    && ln -s $(which fdfind) /usr/local/bin/fd 2>/dev/null || true

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

# Copy CLI tools and docs to /opt (will be copied to persistent sandbox by entrypoint)
COPY gemini-cli /opt/gemini-cli
COPY codex-cli /opt/codex-cli
COPY doc /opt/doc
RUN chmod +x /opt/gemini-cli/*.sh 2>/dev/null || true
RUN chmod +x /opt/codex-cli/*.sh 2>/dev/null || true

# Entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /root/sandbox

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
