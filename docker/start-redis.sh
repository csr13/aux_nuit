#!/bin/bash

if [ ! $UID = 0 ]; then
    echo "[INFO] $(date) run as root";
fi;

name=$1

if [ $name ]; then
    docker run --name $name -d redis;
else
    docker run --name redis -d redis;
fi;
