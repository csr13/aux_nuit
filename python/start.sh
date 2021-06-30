#!/bin/bash

sudo apt-get -y update && sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update && sudo apt-get -y install python3.8 \
    python3.8-dev \
    python3.8-venv \
    python3-pip

echo "export PATH=/home/$USER/.local/bin:$PATH" >> ~/.bashrc && source ~/.bashrc

