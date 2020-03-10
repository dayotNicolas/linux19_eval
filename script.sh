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
        for file in $(find /tmp/in -maxdepth 1 -type f)
        do
            name=${file##*/}
            if [ -f $file ]
            then
                if [ ! -e "/tmp/out/$name.gz" ]
                then
                    echo $file >> /tmp/out/log
                    echo 'OK!'
                    mv $file /tmp/out
                    gzip /tmp/out/$name
                    echo "/tmp/out/$name.gz traité" >> /tmp/out/log
                    #find /tmp/out -name '*.txt' | xargs rm -f
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
        rm /tmp/out/lock
    else
    exit 2
    fi
fi
