#!/bin/bash

sudo apt-get -y update && sudo apt-get install -y postgresql
sudo add-apt-repository -y ppa:mrazavi/gvm
sudo apt-get install -y gvm

sudo -u gvm -g gvm greenbone-nvt-sync
sudo -u gvm -g gvm greenbone-feed-sync --type CERT
sudo -u gvm -g gvm greenbone-feed-sync --type SCAP
sudo -u gvm -g gvm greenbone-feed-sync --type GVMD_DATA

sudo systemctl status ospd-openvas 
sudo systemctl status gvmd
sudo systemctl status gsad
