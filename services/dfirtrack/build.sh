#!/bin/bash

apt-get install -y python3.8 \
    python3.8-venv \
    python3.8-dev \
    python3-dev \
    libpq-dev

git clone https://github.com/stuhli/dfirtrack.git ~/src
python3.8 -m venv ~/src/venv

source ~/src/venv/bin/activate
pip install wheel django psycopg2-binary
cd ~/src && pip install -r requirements.txt && python manage.py makemigrations && \
    python manage.py migrate && \
    python manage.py createcachetable && \
    python manage.py createsuperuser

