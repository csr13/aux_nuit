#!/bin/bash

mkdir -p ~/.vim/syntax/
wget http://www.vim.org/scripts/download_script.php?src_id=19394 -O ~/.vim/syntax/nginx.vim
cat > ~/.vim/filetype.vim <<EOF
au BufRead,BufNewFile /etc/nginx/*,/etc/nginx/conf.d/*,/usr/local/nginx/conf/*,*/conf/nginx.conf if &ft == '' | setfiletype nginx | endif
EOF
