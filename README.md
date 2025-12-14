# Ubuntu Sandbox

Docker container dengan Ubuntu 24.04 LTS dan SSH access untuk development/testing.

## Quick Start

```bash
# Copy environment file
cp .env.example .env
# Edit .env dengan password SSH Anda

# Build dan jalankan
docker-compose up -d --build

# SSH ke container
ssh root@localhost -p 2222
```

## Features

- Ubuntu 24.04 LTS minimal
- SSH access dengan password dari environment variable
- Persistent data di `./sandbox` → `/root/sandbox`
- Persistent SSH host keys (tidak berubah saat rebuild)
- Coolify network ready

## Environment Variables

| Variable       | Default    | Description                   |
| -------------- | ---------- | ----------------------------- |
| `SSH_PASSWORD` | `changeme` | Password untuk root SSH login |
| `TZ`           | `UTC`      | Timezone container            |

## Install Claude Code

```bash
# SSH ke container
ssh root@localhost -p 2222

# Install Node.js LTS
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt-get install -y nodejs

# Install Claude Code
npm install -g @anthropic-ai/claude-code
```
