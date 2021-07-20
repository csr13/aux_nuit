#!/bin/bash
# status ~> untested
# +~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+
# A script to help us onboard devs to
# development servers.
# +~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+

if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit
fi


if [ "$#" -ne 2 ]; then
    echo "[!] usage ~> add-user.sh <username> <sisudo|nosudo>"
    exit 1
fi


user=$1
user_dir=/home/$user
to_sudo=$2


(
    groupadd --force $user && \
    useradd -s /bin/bash -d $user_dir -g $user,users $user && \
    mkdir -p $user_dir && \
    chown $user:$user -R $user_dir
)


if [ $to_sudo = "sisudo" ]; then
    usermod -G sudo,$user,users,www-data $user
else
    usermod -G $user,users,www-data $user
fi

echo "[!] set new password for $user -- make it funky"
passwd $user
