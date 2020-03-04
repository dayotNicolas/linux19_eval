#!/bin/bash
if [ -e /tmp/out/lock ]
then
echo 'code erreur 22: script en cours d execution'
else
    if [ -d /tmp/in ]
    then
    touch /tmp/out/lock
    echo 'OK!'
    cp /tmp/in/* /tmp/out
    chmod 775 /tmp/out
    gzip /tmp/out/*
    rm /tmp/out/lock
    else
    exit 2
    fi
fi
