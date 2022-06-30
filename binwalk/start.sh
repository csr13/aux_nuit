#!/bin/bash

git clone https://github.com/ReFirmLabs/binwalk.git ~/binwalk

if [ ! $(which python3) ] || [ ! $(which python3.8) ]; then
    cd .. && /bin/bash setup.sh python
fi;

cd ~/binwalk && python3 setup.py install

