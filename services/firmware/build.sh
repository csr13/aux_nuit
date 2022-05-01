#!/bin/bash
# ----------------------------------------------------------------
# After this command runs, just do the following after the reboot.
#
# 1) ~/firmware-analyzer/src/install.py
#
# 2) ~/firmware-analyzer/start_all_installed_fact_components
#
# ----------------------------------------------------------------


sudo apt update && sudo apt upgrade && sudo apt install git
git clone https://github.com/fkie-cad/FACT_core.git ~/firmware-analyzer

~/firmware-analyzer/src/install/pre_install.sh && \
    sudo mkdir /media/data && \
    sudo chown -R $USER /media/data
