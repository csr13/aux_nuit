#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "[!] run script as root"
  exit 1
fi

TZ=America/Mexico_City
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

if [ $(which python3.8) ]; then
  echo "[!] Found python3.8";
else
  apt-get update -y && apt-get install -y \
    python3.8 \
    python3.8-dev \
    python3.8-venv
fi

# Install OSQUERY
echo "[!] installing dependencies"
apt-get install -y gnupg software-properties-common

export DEBIAN_FRONTEND=noninteractive
export OSQUERY_KEY=1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $OSQUERY_KEY
add-apt-repository 'deb [arch=amd64] https://pkg.osquery.io/deb deb main'
apt-get -y update
apt-get -y install osquery
