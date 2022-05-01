#!/bin/bash

source ./build.env

if [ $UID -ne 0 ]; then
    echo "[SERVICE MANAGER] It is recommended to run as root";
    echo "[SERVICE MANAGER] Run at your own risk.";
    read -p "[SERVICE MANAGER] continue? y/n >>> " choice;
    if [[ $choice =~ y|n ]]; then
        if [ $choice = n ]; then
            exit 1;
        else
            echo "[SERVICE MANAGER] starting setup ... ";
        fi;
    else
        echo "[SERVICE MANAGER] Invalid choice ... y/n only";
    fi;
fi;

if [ $DOCKER = yes ]; then
    if [ ! $(which docker) ]; then
        echo "[SERVICE MANAGER] this service requires docker";
        echo "[SERVICE MANAGER] run ./setup.sh docker to install";
        exit 1
    fi;
fi;

echo "[SERVICE MANAGER] creating service file";

cat << EOF > /etc/systemd/system/arachni.service
[Unit]
Description=Arachni service
After=network.target

[Service]
User=$USER
Group=$USER
ExecStart=$HOME/src/services/arachni/start.sh
RemainAfterExit=No
Restart=on-failure
RestartSec=5s


[Install]
WantedBy=multi-user.target
EOF


systemctl daemon-reload && \
    systemctl start arachni.service && \
    systemctl status arachni.service
