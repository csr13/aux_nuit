#!/bin/bash

# ======================================================
# A reformated version of the instructions in the Docker
# Online Documentation.
# ======================================================

LSB_RELEASE=$(lsb_release -cs);
DCKR_SRC="deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu";

# ==============================
# Uninstall old versions if any.
# ==============================

sudo apt-get -y remove docker \
    docker-engine \
    docker.io \
    containerd runc \
    && \
    sudo apt-get update -y \
    && \
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

# ===========
# Set sources
# ===========

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

 echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# =======
# Install
# =======

sudo apt-get -y update 
sudo apt-get install -y docker-ce docker-ce-cli containerd.io


