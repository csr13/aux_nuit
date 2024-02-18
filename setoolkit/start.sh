#!/bin/bash

if [ ! $(which python3) ] || [ ! $(which pip3) ]; then
	echo "No python or pip3 installed";
	exit 1;
fi;

if [ -d /setoolkit ]; then
	echo "setoolkit is installed already";
	exit 1;
fi;

echo "Cloning repo"
git clone https://github.com/trustedsec/social-engineer-toolkit/ /setoolkit;

cd /setoolkit && \
	echo "Installing dependencies and running setup on setoolkit/" && \
	pip3 install -r requirements.txt && \
	python3 setup.py


echo "DONE"
