#!/bin/bash

##wordpress##

HOST=$(grep HOST .env | cut -d '=' -f2)

if test -f .firstrun; then
    docker-compose up -d --build
    rm .firstrun
else
    docker-compose up -d $1
fi

if grep -q $HOST /etc/hosts; then
    echo "Host entry exists"
else
    echo "127.0.0.1 $HOST"  | sudo tee -a /etc/hosts > /dev/null
    echo "Added new host entry"
fi

echo "Webserver started at http://$HOST"