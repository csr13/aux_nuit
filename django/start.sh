#!/bin/bash


git clone https://github.com/stuhli/dfirtrack.git ~/src
python3.8 -m venv  ~/src/venv
source ~/src/venv/bin/activate
pip install -r ~/src/requirements.txt
cd ~/src

# Migrate and run commands.
python3 manage.py migrate
python3 manage.py createcachetable
python3 manage.py createsuperuser

if [ $1 = keepalive ]; then
    python3 manage.py runserver 
fi;
