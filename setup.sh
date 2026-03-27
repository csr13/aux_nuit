#!/bin/bash
# This script is the main point of entry for the tools manager.

set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
t=(
    "admin"
    "vim"
    "docker"
    "python"
    "node"
    "tmux"
)

function usage() {
    echo "====================================="
    echo "[AUX NUIT]"
    echo "$(date)"
    echo "Usage ~> ./setup.sh <tool_name>"
    echo "====================================="
    echo "Options"
    echo "====================================="
    for s in "${t[@]}"; do
        printf ">>> %s\n" "$s"
    done
}

function is_supported_tool() {
    local candidate="$1"
    local s
    for s in "${t[@]}"; do
        if [ "$candidate" = "$s" ]; then
            return 0
        fi
    done
    return 1
}

function execute() {
    local loca="$SCRIPT_DIR/$1/start.sh"
    if [ -f "$loca" ]; then
        echo "{+} Executing $loca"
        chmod +x "$loca"
        /bin/bash "$loca"
        return 0
    fi

    echo "{+} $loca not found ..."
    return 1
}

function main() {
    case "$1" in
        "vim") execute "vim" ;;
        "docker") execute "docker" ;;
        "node") execute "node" ;;
        "python") execute "python" ;;
        "git") execute "git" ;;
        "setoolkit") execute "setoolkit" ;;
        "tmux")
            if [ -f "$SCRIPT_DIR/dot/.tmux.conf" ]; then
                cp "$SCRIPT_DIR/dot/.tmux.conf" "$HOME/.tmux.conf"
                return 0
            fi
            echo "{+} $SCRIPT_DIR/dot/.tmux.conf not found ..."
            return 1
            ;;
        *)
            echo "{+} ...."
            usage
            return 1
            ;;
    esac
}

#############
# Execution
#############

if [ $# -lt 1 ]; then
    usage
    exit 0
fi

if ! is_supported_tool "$1"; then
    echo "Invalid option => $1"
    exit 1
fi

main "$1"
exit $?
