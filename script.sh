#!/bin/bash
codeerreur22='code erreur 22: fichier en cours d execution'
codeerreur12='code erreur 12: impossible d effectuer l operation'
currcodeerreur=''
if [ -e /tmp/out/lock ]
then
    currcodeerreur=$codeerreur22
    echo $currcodeerreur
    echo $currcodeerreur >> /tmp/out/log
    exit 22
else
    if [ -d /tmp/in ]
    then
        touch /tmp/out/lock
        for file in $(find /tmp/in -name '*.txt')
        do
            name=${file##*/}
            if [ -f $file ]
            then
                if [ ! -e "/tmp/out/$name.gz" ]
                then
                    echo $file >> /tmp/out/log
                    echo 'OK!'
                    cp /tmp/in/* /tmp/out
                    chmod 775 /tmp/out
                    gzip /tmp/out/*
                    echo "/tmp/out/$name.gz traité" >> /tmp/out/log
                    find /tmp/out -name '*.txt' | xargs rm -f
                else
                    continue
                fi
            else
                currcodeerreur=$codeerreur12
                echo $currcodeerreur
                echo $currcodeerreur >> /tmp/out/log
                exit 12
            fi
        done
        rm /tmp/out/lock.gz
        if [ -e /tmp/out/log.gz ]
        then
            rm /tmp/out/log.gz
        fi
    else
    exit 2
    fi
fi
