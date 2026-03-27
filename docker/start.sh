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

resolve_docker_repo_distro() {
    local os_id="$1"
    case "$os_id" in
        ubuntu|debian)
            echo "$os_id"
            ;;
        *)
            echo ""
            ;;
    esac
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
    log "Official script failed or not supported. Falling back to manual apt method..."
    if [[ ! -f /etc/os-release ]]; then
        log "Cannot detect distro (/etc/os-release missing). Aborting."
        exit 1
    fi
    # shellcheck disable=SC1091
    . /etc/os-release
    repo_distro="$(resolve_docker_repo_distro "${ID:-}")"
    if [[ -z "$repo_distro" ]]; then
        log "Unsupported distro for apt fallback: ${ID:-unknown}. Please install Docker manually."
        exit 1
    fi
    
    log "Removing any conflicting packages..."
    apt-get remove -y docker docker-engine docker.io containerd runc || true

    log "Installing prerequisites..."
    apt-get update
    apt-get install -y ca-certificates curl gnupg lsb-release

    log "Adding Docker GPG key..."
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL "https://download.docker.com/linux/${repo_distro}/gpg" \
        | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    log "Adding Docker repository..."
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/${repo_distro} $(lsb_release -cs) stable" \
      | tee /etc/apt/sources.list.d/docker.list > /dev/null

    log "Installing latest Docker Engine + Compose plugin..."
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

if command -v systemctl >/dev/null 2>&1 && [[ -d /run/systemd/system ]]; then
    log "Enabling and starting Docker..."
    systemctl enable --now docker
else
    log "systemd not detected; skipping service enable/start. Start Docker manually for your init system."
fi

target_user="${SUDO_USER:-}"
if [[ -z "$target_user" ]]; then
    target_user="${DOCKER_USER:-}"
fi
if [[ -z "$target_user" ]]; then
    target_user="$(logname 2>/dev/null || true)"
fi

if [[ -n "$target_user" && "$target_user" != "root" ]] && id "$target_user" >/dev/null 2>&1; then
    usermod -aG docker "$target_user"
    log "User $target_user added to docker group (re-login required)"
else
    log "No non-root target user detected for docker group assignment; skipping."
fi

log "Verifying installation..."
docker version --format 'Docker: {{.Server.Version}}'
docker compose version

log "Docker + Compose installed successfully!"
echo
echo "Test it: docker run --rm hello-world"
echo "Use Compose: docker compose up   (no hyphen!)"
