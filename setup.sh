#!/bin/bash

if [ $# -lt 1 ]; then
    usage;
    exit 0
fi

function usage () {
    local t=(
        "admin"
        "vim"
        "docker"
        "python"
        "node"
        "git"
        "tmux"
        "osquery"
    )
    
    echo "====================================="
    echo "[AUX NUIT]"
    echo "$(date)"
    echo "Usage ~> ./setup.sh <tool_name>"
    echo "====================================="
    echo "Options"
    echo "====================================="
    
    for s in ${!t[@]}; do
        printf ">>> %s\n" "${t[$s]}";
    done
}


function execute() {
    if [ $1 = services ]; then 
        local loca="$(pwd)/$1/manager.sh";
    else
        local loca="$(pwd)/$1/start.sh";
    fi;

    if [ -x $loca ]; then
        echo "{+} Executing $loca";
        chmod +x $loca && /bin/bash $loca;
    else
        echo "{+} $loca not found ...";
    fi
    
    exit 0;
}


function main() {
    case $1 in 
        "vim") execute "vim" ;;
        "docker") execute "docker" ;;
        "node") execute "node" ;;
        "python") execute "python" ;;
        "osquery") execute "osquery" ;;
        "git") execute "git" ;;
        "services") execute "services" ;;
        "tmux") 
            if [ -f dot/.tmux.conf ]; 
                then cp dot/.tmux.conf ~/.tmux.conf; 
            fi
        ;;
        *) echo "{+} ...."; usage; exit 0 ;;
    esac
}

main $1
