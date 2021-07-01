#!/bin/bash
# =======================
# Some personal shortcuts
# =======================

if [ "$#" -ne 2 ]; then
    echo "[!] usage ~> start.sh <git-username> <git-email>"
    exit 1
fi

git config --global user.name $1
git config --global user.email $2

git config --global alias.unstage 'reset HEAD --'
git config --global alias.br branch
git config --global alias.cmt commit
git config --global alias.st status
