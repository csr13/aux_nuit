#!/bin/bash

# ===============================================================
# Universal Docker + Compose installation script (2025 edition)
# Try official get.docker.com first, works on 99% of distros
# If it fails, fall back to manual Ubuntu/Debian method
# ===============================================================

set -euo pipefail

log() {
    echo "[$(date '+%H:%M:%S')] $*"
}

log "=== Universal Docker + Compose installer ==="

# Must be root
if [[ $EUID -ne 0 ]]; then
    echo "Run as root (or with sudo)"
    exit 1
fi

log "Trying official get.docker.com script..."
if curl -fsSL https://get.docker.com | sh -s -- --quiet; then
    log "Official script succeeded! Docker installed."
else
    log "Official script failed or not supported. Falling back to manual Ubuntu/Debian method..."
    
    log "Removing any conflicting packages..."
    apt-get remove -y docker docker-engine docker.io containerd runc || true

    log "Installing prerequisites..."
    apt-get update
    apt-get install -y ca-certificates curl gnupg lsb-release

    log "Adding Docker GPG key..."
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    log "Adding Docker repository..."
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
      | tee /etc/apt/sources.list.d/docker.list > /dev/null

    log "Installing latest Docker Engine + Compose plugin..."
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

log "Enabling and starting Docker..."
systemctl enable --now docker

if [[ -n "${SUDO_USER:-}" ]]; then
    usermod -aG docker "$SUDO_USER"
    log "User $SUDO_USER added to docker group (re-login required)"
fi

log "Verifying installation..."
docker version --format 'Docker: {{.Server.Version}}'
docker compose version

log "Docker + Compose installed successfully!"
echo
echo "Test it: docker run --rm hello-world"
echo "Use Compose: docker compose up   (no hyphen!)"
