#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

cp "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
