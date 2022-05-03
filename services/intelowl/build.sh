#!/bin/bash

source ./build.env

git clone https://github.com/intelowlproject/IntelOwl $DEST_PATH;

cd intelowl/
cd configuration/nginx/

sed -i 's/listen 80/listen 8000' http.conf

cd $DEST_PATH
cat configuration/nginx/http.conf
#cd docker/

#cp env_file_app_template env_file_app
#cp env_file_postgres_template env_file_postgres
#cp env_file_integrations_template env_file_integrations

#cd ..

#./initialize.sh
#python3 start.py prod up

#docker exec -ti intelowl_uwsgi python3 manage.py createsuperuser
