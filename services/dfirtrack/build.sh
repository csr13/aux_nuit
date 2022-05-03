#!/bin/bash

apt-get install -y python3.8 \
    python3.8-venv \
    python3.8-dev \
    python3-dev \
    libpq-dev

git clone https://github.com/stuhli/dfirtrack.git ~/dfirtrack && \
    python3.8 -m venv ~/dfirtrack/venv

cat << EOF > $HOME/dfirtrack/local_settings.py
from dfirtrack.settings import *

DEBUG = True

ALLOWED_HOSTS = ['127.0.0.1']
EOF

source ~/src/venv/bin/activate && \
    pip install wheel \
    django \
    psycopg2-binary \
    git+https://github.com/dfirtrack/dfirtrack-api-python-client.git && \
    cd ~/src && pip install -r requirements.txt && \
        python manage.py makemigrations --settings=dfirtrack.local_settings.py && \
        python manage.py migrate --settings=dfirtrack.local_settings.py && \
        python manage.py createcachetable --settings=dfirtrack.local_settings.py && \
        python manage.py createsuperuser --settings=dfirtrack.local_settings.py

echo "[SERVICE MANAGER] activate the environment found at $HOME/dfirtrack/venv first.";
echo "[SERVICE MANAGER] run: python manage.py runserver --settings=dfritrack/local_settings.py to start";

cat << EOF > /etc/systemd/system/dfirtrack.service
[Unit]
Description=Katz meow meow incident response
After=network.target

[Service]
User=$USER
Group=$USER
ExecStart=$HOME/dfirtrack/venv/bin/python manage.py runserver --settings=dfirtrack.local_settings
RemainAfterExit=No
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload && \
    systemctl start dfirtrack.service && \
    systemctl status dfirtrack.service
