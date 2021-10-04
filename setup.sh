#!/bin/bash


function usage () {
    local t=(
        "vim"
        "docker"
        "python"
        "node"
        "git"
        "tmux"
    )
    echo "--------------------------------"
    echo "Usage ~> ./setup.sh <tool_name>"
    echo "--------------------------------"
    echo "Tools"
    echo "--------------------------------"
    for s in ${!t[@]}; do
        printf "%s) %s\n" "$s" "${t[$s]}";
    done
}

function execute() {
    local loca="$(pwd)/$1/start.sh";
    if [ -x $loca ]; then
        echo "{+} Executing $loca";
        chmod +x $loca && /bin/bash $loca;
    else
        echo "{+} $loca not found ...";
    fi
    exit 0;
}

if [ $# -lt 1 ]; then
    usage;
    exit 0
fi

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
    *) echo "{+} ...."; exit 0 ;;
esac

