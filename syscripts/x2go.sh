#!/bin/bash
# status ~> untested
# ~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+
# x2go allows remote access to servers using a graphical environment
# I use it to set development environments on servers for the people
# that work for us.
# ~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+

# shhh.
export DEBIAN_FRONTEND=noninteractive

# Sometimes I want full, sometimes I want minimal ubuntu xfce

if [ "$#" -ne 1 ]; then
    version="minimal"
else
    version="full"
fi


# might get a prompt on console on this step
if [ $version = "full" ]; then
    sudo apt-get install -y xubuntu-desktop
else
    sudo apt-get install -y xubuntu-core
fi

# Now install x2go server and x2go server xsession for magic cookies.
sudo apt-get update && sudo apt-get install -y \
    x2goserver \
    x2goserver-xsession

sudo systemctl start x2goserver
sudo systemctl status x2goserver

