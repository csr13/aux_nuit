#!/bin/bash
# Import env variables, meow >.<

source ./build.env

if [ ! $(which docker) ]; then
    echo "[SERVICE MANAGER] docker must be installed"
    exit 1
fi;

if [ ! $(which python3) ]; then
    echo "[SERVICE MANAGER] python3 required";
    exit 1
fi;

git clone https://github.com/intelowlproject/IntelOwl $DEST_PATH;

cd $DEST_PATH/docker && \
    python3 -c "meow=open('default.yml','r');kat=meow.read().replace('- \"443:443\"','');meow.close();meow=open('default.yml','w').write(kat)" && \
    python3 -c "meow=open('default.yml','r');kat=meow.read().replace('80:80','127.0.0.1:6969:6969');meow.close();meow=open('default.yml','w').write(kat)"

cd $DEST_PATH/docker && \
        cp env_file_app_template env_file_app && \
        cp env_file_postgres_template env_file_postgres && \
        cp env_file_integrations_template env_file_integrations

cd $DEST_PATH && \
    /bin/bash ./initialize.sh && \
    if [ $LOCAL = yes ]; then 
        python3.8 start.py prod up -d; 
    else 
        python3 start.py prod up -d;
    fi;

docker exec -ti intelowl_uwsgi python3 manage.py migrate
docker exec -ti intelowl_uwsgi python3 manage.py createsuperuser
