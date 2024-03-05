#!/bin/bash

set -e

echo "Installing aircrack-ng in /opt/aircrack";

wget https://download.aircrack-ng.org/aircrack-ng-1.7.tar.gz && \
	-O /opt/aircrack/aircrack-ng-1.7.tar.gz

cd /opt/aircrack && \
	tar -zxvf aircrack-ng-1.7.tar.gz &&  \
	cd ./aircrack-ng-1.7 && \
	autoreconf -i && \
	./configure --with-experimental && \
	make && \
	make install && \
	ldconfig
