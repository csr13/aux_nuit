#!/bin/bash
# This script is the main point of entry for the tools manager.

set -e

t=(
    "admin"
    "vim"
    "docker"
    "python"
    "node"
    "git"
    "tmux"
    "osquery"
    "setoolkit"
)


function usage () {
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
    local loca="$(pwd)/$1/start.sh";
    if [ -f $loca ]; then
        echo "{+} Executing $loca";
        chmod +x $loca && /bin/bash $loca;
    else
        echo "{+} $loca not found ...";
    fi
    exit 0;
}


function delete_service () {
    ########## Main exception/s ##############
    if [ $1 = "tmux" ]; then
        rm ~/.tmux.conf
        printf "Remove tmux from system: yes/no"; 
        read choice;
        echo "$choice";
        exit 1;
    fi;
    ########## Run uninstall.sh ##############
    local loca="$(pwd)/$1/uninstall.sh";
    if [ -f $loca ]; then
        echo "{+} Executing $loca"; chmod +x $loca && /bin/bash $loca;
    else
        echo "{+} $loca not found ...";
    fi; 
    exit 0;
}


function main() {
    case $1 in 
        "vim") execute "vim" ;;
        "docker")  execute "docker" ;;
        "node") execute "node" ;;
        "python") execute "python" ;;
        "git") execute "git" ;;
        "setoolkit") execute "setoolkit" ;;
        "tmux") if [ -f dot/.tmux.conf ]; then cp dot/.tmux.conf ~/.tmux.conf; fi ;;
        "--delete") delete_service $2 ;;
        *) echo "{+} ...."; usage; exit 0 ;;
    esac
}

#############
# Execution
#############


if [ $# -lt 1 ]; then
    usage;
    exit 0
fi

if [ $1 = "--delete" ] && [ $# -eq 1 ]; then
    echo "Missing service name. Usage: --delete <service-name>" exit 1;
    exit 1;
fi;


if [ $# -eq 2 ]; then
    for s in ${!t[@]}; do
        i=s; 
        s="${t[$s]}";
        if [ $1 = "--delete" ]; then 
            if [ $2 = $s ]; then
                main $1 $2; 
            fi;
        else
            echo "Invalid option $1"; exit 1;
        fi;
    done; 
    echo "Invalid service to delete => $2"; exit 1;
else
    for s in ${!t[@]}; do
        i=s; 
        s="${t[$s]}";
        if [ $1 = $s ]; then 
            main $1; 
            exit 1; 
        fi;
    done; 
    echo "Invalid option => $1"; exit 1;
fi;
