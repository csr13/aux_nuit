#!/bin/bash

if [ -f ./zapdaemon.service ]; then
    sudo cp ./zapdaemon.service /etc/systemd/system/zapdaemon.service;
    sudo systemctl daemon-reload
    sudo systemctl start zapdaemon.service
else
    echo "zapdaemon.service not found"
fi
