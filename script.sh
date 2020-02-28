#!/bin/bash
if [ -d /tmp/in ]
then
echo 'OK!'
cp /tmp/in/* /tmp/out
chmod 775 /tmp/out
gzip /tmp/out/*
else
exit 2
fi
