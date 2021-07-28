#!/bin/bash

# ~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+
# x2go allows remote access to servers using a graphical environment
# I use it to set development environments on servers for the people
# that work for us.
# ~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+

export DEBIAN_FRONTEND=noninteractive

if [ "$#" -ne 1 ]; then
    version="minimal"
else
    version="full"
fi

if [ $version = "full" ]; then
    sudo apt-get install -y xubuntu-desktop
else
    sudo apt-get install -y xubuntu-core
fi

sudo apt-get update && sudo apt-get install -y \
    x2goserver \
    x2goserver-xsession

sudo systemctl start x2goserver
sudo systemctl status x2goserver

