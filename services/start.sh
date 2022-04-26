#!/bin/bash


function setup_arachni () {
    cp ./arachni/arachni.service /etc/systemd/system;
    sudo systemctl daemon-reload;
    sudo systemctl start arachni.service;
    sudo systemctl status arachni.service;
}


function start_service() {
    if [ -f $1 ]; then
        /bin/bash $1;
    else
        local p="$(pwd)/$1";
        echo "[INFO] $(date) $p does not exist."
    fi;
}


function main () {
    start_service gvm/build.sh;
    start_service firmware/setup-firmware.sh;
    setup_arachni;
    start_service nikto/build.sh;
    start_service zap/build.sh;
    start_service tests/build.sh;
    start_service cve-search/build.sh;
}


main
