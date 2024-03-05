#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: ./setup.sh admin create-user|delete-user";
    exit 1;
fi;

param=$1
user=$2

if [[ $param ~= "create-user" ]]; then
    /bin/bash ./admin/create_user.sh $user
elif [[ $param ~= "delete-user" ]]; then
    /bin/bash ./admin/delete_user.sh $user
else
    echo "valid options are create-user and delete-user";
    exit 1;
fi;
