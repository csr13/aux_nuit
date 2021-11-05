#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y install git 
apt-get -y install make 
apt-get -y install clang
apt-get -y install libxt-dev
apt-get -y install libpython3.9-dev

git clone https://github.com/vim/vim.git /tmp/vim 

cd /tmp/vim
make
make test
make install

vim --version

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

chmod +x post-vim.sh && post-vim.sh

cp .vimrc ~/.vimrc

echo "[!] run vim -c 'PluginInstall'"

