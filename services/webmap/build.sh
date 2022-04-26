#!/bin/bash

mkdir /tmp/webmap;

docker run -d \
    --name webmap \
    -h webmap \
    -v /tmp/webmap:/opt/xml \
    reborntc/webmap;
