#!/bin/bash

function loggit() {
    echo "[INFO] $(date) $1";
}

function generate_keys() {
    # TO DO
    cd "$1" && \
        loggit "making $1/.ssh folder" && \
        mkdir .ssh && \
        loggit "changing permissions to 700" && \
        chmod 700 .ssh && \
        loggit "gerating keys" && \
        cd .ssh && ssh-keygen -f id_rsa -t rsa -N '' && \
        loggit "changing keys mode to 600" && \
        chmod 600 "$1"/.ssh/* && \
        loggit "changing ownership of files to $2"
        chown -R "$2":"$2" "$1"/.ssh
        loggit "copying .pub to authorized keys"
        cp id_rsa.pub authorized_keys
    loggit "Copying $2 keys to root home.";
    if [ -d ~/ssh_keys ]; then
        cp -r "$1"/.ssh ~/ssh_keys/"$2";
    else
        mkdir -p ~/ssh_keys && cp -r "$1"/.ssh ~/ssh_keys/"$2";
    fi;
}

if [ $UID -ne 0 ]; then
    echo "[INFO] $(date) run as root";
    exit 1;
fi;

read -p "Enter username: " username

if id "$username" >/dev/null 2>&1; then
    loggit "$username exists, use another username."
    exit 1
fi

group=$username

if [ $(getent group $group) ]; then
    loggit "group $group exists."
else
    groupadd "$group";
fi

useradd -s /bin/bash -d /home/"$username" -g "$group" "$username";

mkdir /home/"$username" && chown -R "$username":"$group" /home/"$username"

loggit "User $username created."

read -p "[INFO] Generate keys for user? yes or no: " answer;

if [[ $answer = yes ]];then
    loggit "Generating keys for $username ... ";
    sleep 2
    generate_keys /home/"$username" $username
else
    loggit "Not generating keys for $username";
fi;

exit 1
