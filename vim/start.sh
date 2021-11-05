#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

chmod +x vim/post-vim.sh && vim/post-vim.sh

cp vim/.vimrc ~/.vimrc
