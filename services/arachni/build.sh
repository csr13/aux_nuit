#!/bin/bash

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
