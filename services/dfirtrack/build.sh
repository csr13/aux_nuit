#!/bin/bash

apt-get install -y python3.8 \
    python3.8-venv \
    python3.8-dev \
    python3-dev \
    libpq-dev

git clone https://github.com/stuhli/dfirtrack.git ~/src
python3.8 -m venv ~/src/venv

cat << EOF > $HOME/src/dfirtrack/local_settings.py
from dfirtrack.settings import *

DEBUG = True

ALLOWED_HOSTS = ['127.0.0.1']
EOF

source ~/src/venv/bin/activate
pip install wheel django psycopg2-binary
cd ~/src && pip install -r requirements.txt && \
    python manage.py makemigrations --settings=dfirtrack.local_settings.py && \
    python manage.py migrate --settings=dfirtrack.local_settings.py && \
    python manage.py createcachetable --settings=dfirtrack.local_settings.py && \
    python manage.py createsuperuser --settings=dfirtrack.local_settings.py

echo "[SERVICE MANAGER] run: python manage.py runserver to start
