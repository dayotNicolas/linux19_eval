#!/bin/bash
if [ -e /tmp/out/lock ]
then
    echo 'code erreur 22: script en cours d execution'
    exit 2>>/tmp/out/log
else
    if [ -d /tmp/in ]
    then
        touch /tmp/out/lock
        for file in /tmp/in/*
        do
            if [ -e $file ] && [ -f $file ]
            then
                echo 'OK!'
                cp /tmp/in/* /tmp/out
                chmod 775 /tmp/out
                gzip /tmp/out/*
                rm /tmp/out/lock.gz
            else
                echo  'code erreur 12: impossible d effectuer l operation'
                exit 2>>/tmp/out/log
            fi
        done
    else
    exit 2
    fi
fi
