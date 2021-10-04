#!/bin/bash


function execute() {
    local loca="$(pwd)/$1/start.sh";
    if [ -x $loca ]; then
        echo "{+} Executing $loca";
        chmod +x $loca && /bin/bash $loca;
    else
        echo "{+} $loca not found ...";
    fi
    exit 1;
}


case $1 in 
    "vim") execute "vim" ;;
    "docker") execute "docker" ;;
    "node") execute "node" ;;
    "python") execute "python" ;;
    "osquery") execute "osquery" ;;
    "git") execute "git" ;;
    "tmux") 
        if [ -x dot/.tmux.conf ]; 
            then cp dot/.tmux.conf ~/.tmux.conf; 
        fi
    ;;
    *) echo "{+} ...."; exit 1 ;;
esac

