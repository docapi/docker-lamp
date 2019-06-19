#!/bin/bash

DOMAIN=myweb.test

docker-compose up -d

if grep -q $DOMAIN /etc/hosts; then
    echo "Host entry exists"
else
    echo "127.0.0.1 $DOMAIN"  | sudo tee -a /etc/hosts > /dev/null
    echo "Added new host entry"
fi

echo "Webserver started at http://$DOMAIN"