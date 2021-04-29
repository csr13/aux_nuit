#!/bin/bash

wget -O nginx.vim http://www.vim.org/scripts/download_script.php\?src_id\=19394
mkdir -p ~/.vim/syntax
mv nginx.vim ~/.vim/syntax
