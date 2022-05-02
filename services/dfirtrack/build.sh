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

echo "[SERVICE MANAGER] activate the environment found at $HOME/src/venv first."
echo "[SERVICE MANAGER] run: python manage.py runserver --settings=dfritrack/local_settings.py to start";
