#!/bin/bash
# status ~> untested


if [ "$#" -ne 1 ]; then
    echo "[!] usage ~> add-user.sh <username>"
fi


user=$1
user_dir=/home/$user

groupadd $user && useradd -s /bin/bash -d $user_dir
mkdir -p /home/$user && chown $user:$user -R $user_dir

# The only manual step
passwd $user


