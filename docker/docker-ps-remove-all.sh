#!/bin/bash

# ==============================================================
# Stops and removes all containers, even if the container is up.
# ==============================================================


for container in $(docker ps -a --format={{.ID}}); do
    docker stop $container
    docker rm $container
done
