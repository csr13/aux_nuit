#!/bin/bash

# Using Ubuntu
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get -y update && sudo apt-get install -y nodejs
mkdir ~/.npm-global
npm config set prefix '/.npm-global'

echo "export PATH=~/.npm-global/bin:$PATH" >> ~/.bashrc && source ~/.bashrc

