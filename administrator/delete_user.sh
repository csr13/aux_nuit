#!/bin/bash


function loggit() {
    echo "[INFO] $(date) $1";
}

if [ $UID -ne 0 ]; then
    echo "[INFO] $(date) run as root";
    exit 1;
fi;

read -p "Enter user to delete: " username

if id "$username" >/dev/null 2>&1; then
    loggit "User $username exists, deleting";
    
    loggit "Killing all user processes";
    killall -u "$username";
    
    loggit "Deleting user";
    userdel "$username";
    
    loggit "Deleting group";
    groupdel "$username";
    
    loggit "Removing home directory";
    rm -rfvd /home/"$username";

    loggit "User removed from system";
fi
