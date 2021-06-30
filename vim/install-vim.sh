#!/bin/bash

export PREFIX = ~/vim
PYTHON_VERSION = "3.8"


(
    sudo apt-get autoremove -y cmatrix --purge \
        && sudo apt-get -y clean \
        && sudo apt-get -y autoclean \
        && sudo apt-get update \
        && sudo apt-get -y git make clang build-deep vim
)


(

    git clone https://github.com/vim/vim.git ~/vim \
        && cd ~/vim \
        && sed -i 'CONF_OPT_PYTHON3 = --enable-python3interp/^#//g' Makefile 
)


(
    ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-python3interp \
            --with-python3-config-dir=/usr/lib/python"$PYTHON_VERSION"/config-"$PYTHON_VERSION"m-x86_64-linux-gnu \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-cscope \
            --enable-gui=auto \
            --enable-gtk2-check \
            --with-x \
            --with-compiledby=$USER \
            --prefix=$PREFIX
)


(
    make && \
    make test && \
    make install \
)
