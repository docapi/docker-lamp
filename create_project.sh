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

# Choose Hostname local dev
DEFAULT_HOST="docker.test"
while [ -z ${HOST_NAME} ];
do
    read -e -p "Choose hostname for local development [docker.test]:" HOST_NAME
    HOST_NAME="${HOST_NAME:-${DEFAULT_HOST}}"
done

# Choose local dev web port
DEFAULT_PORT="80"
while [ -z ${WEB_PORT} ];
do
    read -e -p "Choose web port for local development [80]:" WEB_PORT
    WEB_PORT="${WEB_PORT:-${DEFAULT_PORT}}"
done


# Choose Hostname staging
DEFAULT_STAGING_HOST="staging.domain"
while [ -z ${STAGE_HOST_NAME} ];
do
    read -e -p "Choose hostname for staging [staging.domain]:" STAGE_HOST_NAME
    STAGE_HOST_NAME="${STAGE_HOST_NAME:-${DEFAULT_STAGING_HOST}}"
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

# Create project folder
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}

# Copy scripts
cp {start_system.sh,stop_system.sh,docker-compose.yml} ${DESTINATION_PATH}/${FOLDER_NAME}/

# Create www folder
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/www
cp www/index.php  ${DESTINATION_PATH}/${FOLDER_NAME}/www/index.php
cp www/dbtest.php  ${DESTINATION_PATH}/${FOLDER_NAME}/www/dbtest.php

# Create docker folder
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/docker
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/docker/db
cp docker/db/.gitignore  ${DESTINATION_PATH}/${FOLDER_NAME}/docker/db/
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/docker/logs
cp docker/logs/.gitignore  ${DESTINATION_PATH}/${FOLDER_NAME}/docker/logs/
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/docker/webserver
cp {docker/webserver/Dockerfile,docker/webserver/php.ini,docker/webserver/docker-php-pecl-install} ${DESTINATION_PATH}/${FOLDER_NAME}/docker/webserver

# Insert PHP engine into dockerfile
sed -i '' "s/\php:7\.2-apache/${opt}/g" ${DESTINATION_PATH}/${FOLDER_NAME}/docker/webserver/Dockerfile

# Create env file
echo "HOST=${HOST_NAME}" > ${DESTINATION_PATH}/${FOLDER_NAME}/.env
echo "DB=${DB_NAME}" >> ${DESTINATION_PATH}/${FOLDER_NAME}/.env
echo "DB_ROOT_PASSWORD=docker" >> ${DESTINATION_PATH}/${FOLDER_NAME}/.env
echo "DB_USER=dockeruser" >> ${DESTINATION_PATH}/${FOLDER_NAME}/.env
echo "DB_PASSWORD=12345678" >> ${DESTINATION_PATH}/${FOLDER_NAME}/.env
echo "WEB_PORT=${WEB_PORT}" >> ${DESTINATION_PATH}/${FOLDER_NAME}/.env

# Create staging env file
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/build
mkdir ${DESTINATION_PATH}/${FOLDER_NAME}/build/staging
echo "HOST=${STAGE_HOST_NAME}" > ${DESTINATION_PATH}/${FOLDER_NAME}/build/staging/.env
echo "DB=${DB_NAME}" >> ${DESTINATION_PATH}/${FOLDER_NAME}/build/staging/.env
echo "DB_ROOT_PASSWORD=fhur8§hhdAA!!a" >> ${DESTINATION_PATH}/${FOLDER_NAME}/build/staging/.env
echo "DB_USER=dockeruser" >> ${DESTINATION_PATH}/${FOLDER_NAME}/build/staging/.env
echo "DB_PASSWORD=4hfGggJaj2!" >> ${DESTINATION_PATH}/${FOLDER_NAME}/build/staging/.env
echo "WEB_PORT=80" >> ${DESTINATION_PATH}/${FOLDER_NAME}/build/staging/.env


# Create first run check file
touch ${DESTINATION_PATH}/${FOLDER_NAME}/.firstrun

echo -e "\033[32mEverything done!\033[0m"