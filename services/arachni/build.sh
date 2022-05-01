#!/bin/bash

docker rm --force arachni
docker run -d \
    -p 127.0.0.1:7331:7331 \
    --name arachni \
    arachni/arachni:latest
