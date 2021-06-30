#!/bin/bash

wget -O nginx.vim http://www.vim.org/scripts/download_script.php\?src_id\=19394
mkdir -p ~/.vim/syntax
mv nginx.vim ~/.vim/syntax
touch ~/.vim/filetype.vim
echo "au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif" > ~/.vim/filetype.vim
