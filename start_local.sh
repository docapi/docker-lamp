#!/bin/bash

HOST=$(grep HOST .env | cut -d '=' -f2)

docker-compose up -d $1 

if grep -q $HOST /etc/hosts; then
    echo "Host entry exists"
else
    echo "127.0.0.1 $HOST"  | sudo tee -a /etc/hosts > /dev/null
    echo "Added new host entry"
fi

echo "Webserver started at http://$HOST"