#!/bin/bash

source ./build.env

git clone https://github.com/certsocietegenerale/fame.git $DEST_DIR

cd $DEST_DIR/docker
docker build -t famedev:latest .
docker run -it -v /var/run/docker.sock:/var/run/docker.sock \
    -v $TEMP_DIR:/opt/fame/temp --name famedev -p 127.0.0.1:4200:4200 famedev:latest
