#!/bin/bash

function list_services() {
    for each in $services_available; do
        echo ">>> $each"
    done;
}

function build_service() {
    echo "[SERVICE MANAGER] Finding build context for choice: $1";
    if [ -d $1 ] && [ -x $1/build.sh ]; then
        echo "[SERVICE MANAGER] Building $1";
        local service_path="$(pwd)/$1";
        local build_script="$(pwd)/$1/build.sh";
        # TO DO:
        # execute the build script, but first finish dynamically allocating paths on
        # service files and build scripts.
    else
        echo "[SERVICE MANAGER] Unable to find service";
        exit 1
    fi
}

# ~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~
# Exec part

services_available=$(ls -d */ | cut -f 1 -d "/");

cat << EOF
=================================
[SERVICE MANAGER]
$(date)
Available services
=================================
EOF

list_services;

read -p '>>> Name of the service to build: ' option_choice

build_service $option_choice;
