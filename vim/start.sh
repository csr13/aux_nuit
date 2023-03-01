#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

chmod +x vim/post-vim.sh && vim/post-vim.sh

cp vim/.vimrc ~/.vimrc
