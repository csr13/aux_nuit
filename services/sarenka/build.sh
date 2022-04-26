#!/bin/bash

###########################################################
# Configure repository and install dependencies
###########################################################

git clone https://github.com/pawlaczyk/sarenka.git ~/sarenka

cd ~/sarenka && \
    python3.8 -m venv venv && \
    source venv/bin/activate && \
    pip install -r requirements.txt && \
    deactivate;

cd ~/sarenka && sed -i \
    's/CredentialsNotFoundError/UserCredentialsError/' \
    ./sarenka/backend/api_searcher/searcher_full.py;

cd ~/sarenka && \
    source venv/bin/activate && \
    python manage.py makemigrations && \
    python manage.py migrate && \
    deactivate;


##########################################################
# Configure Service file for Sarenka Backend
##########################################################

sudo cat << EOF > /etc/systemd/system/sarenka.service
[Unit]
Description=Sarenka backend service
After=network.target

[Service]
User=localadmin
Group=localadmin
WorkingDirectory=/home/localadmin/sarenka
ExecStart=/home/localadmin/sarenka/venv/bin/python sarenka/backend/manage.py runserver 127.0.0.1:8887
RemainAfterExit=No
Restart=on-failure
RestartSec5s

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl start sarenka.service && \
    sudo systemctl status sarenka.service
