#!/bin/bash
#!/bin/bash

function usage() {
    echo "[USAGE] /bin/bash start-postgres-db.sh <container-name> <db-password> <db_name>"
    exit 1
}

if [ ! $UID = 0 ]; then
    echo "[INFO] $(date) run as root";
fi;

if [ ! $(which docker) ]; then
    echo "[!] No docker found on $PATH, install docker."
    exit 1
fi

if [ ! $# -eq 3 ]; then
    usage
fi;

container_name=$1;
db_password=$2;
db_name=$3;

########################################
# Install mysql dev for python bindings.
########################################

apt-get install -y python3-dev \
    default-libmysqlclient-dev \
    build-essential

########################################
# Install mysql dev for python bindings.
########################################

docker run --name $container_name \
    -e MYSQL_ROOT_PASSWORD=$db_password \
    -e MYSQL_DATABASE=$db_name \
    -d mysql:latest;

