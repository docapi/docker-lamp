#!/bin/bash

# Choose a folder name
while [ -z ${FOLDER_NAME} ];
do
    printf "Choose name of target folder (e.g.: myproject): "
    read FOLDER_NAME
done

# Choose a destination path
PATH_VALID="false"
while [ ${PATH_VALID} == "false" ];
do
    printf "Choose a destination path (without trailing /): "
    read DESTINATION_PATH

    if [ ! -d ${DESTINATION_PATH} ] || [[ ${DESTINATION_PATH} == "" ]];
    then
        echo -e "\033[41mChosen path is not valid !!!\033[0m"
    else
        PATH_VALID="true"
    fi
done

# Choose Hostname
DEFAULT_HOST="docker.test"
while [ -z ${HOST_NAME} ];
do
    read -e -p "Choose hostname [docker.test]:" HOST_NAME
    HOST_NAME="${HOST_NAME:-${DEFAULT_HOST}}"
done

# Choose DBname
DEFAULT_DB="docker"
while [ -z ${DB_NAME} ];
do
    read -e -p "Choose database name [docker]:" DB_NAME
    DB_NAME="${DB_NAME:-${DEFAULT_DB}}"
done


PS3='Please enter your choice: '
options=("php:7.1-apache" "php:7.2-apache" "php:7.3-apache" "php:5.6-apache")
select opt in "${options[@]}"
do
    case $REPLY in
        [1-4]*)
            break
            ;;
        *) echo "invalid option $REPLY, please select 1-4";;
    esac
done
echo $opt

# Create project folder
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}

# Copy scripts
cp {start_local.sh,stop_local.sh,docker-compose.yml} ${DESTINATION_PATH}/${FOLDER_NAME}/

# Create www folder
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/www
cp www/index.php  ${DESTINATION_PATH}/${FOLDER_NAME}/www/index.php

# Create docker folder
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/docker
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/docker/db
cp docker/db/.gitignore  ${DESTINATION_PATH}/${FOLDER_NAME}/docker/db/
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/docker/logs
cp docker/logs/.gitignore  ${DESTINATION_PATH}/${FOLDER_NAME}/docker/logs/
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/docker/webserver
cp {docker/webserver/Dockerfile,docker/webserver/php.ini} ${DESTINATION_PATH}/${FOLDER_NAME}/docker/webserver

# Create env file
echo "HOST=${HOST_NAME}" > ${DESTINATION_PATH}/${FOLDER_NAME}/.env
echo "DB=${DB_NAME}" >> ${DESTINATION_PATH}/${FOLDER_NAME}/.env