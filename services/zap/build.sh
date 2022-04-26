#!/bin/bash

sudo cp ./zapdaemon.service /etc/systemd/system/zapdaemon.service
sudo systemctl daemon-reload
sudo systemctl start zapdaemon.service
sudo systemctl status zapdaemon.service

