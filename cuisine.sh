#!/bin/sh
IMAGE=$1
HTTP=${IMAGE:0:4}
EXTENS=${IMAGE: -4}
echo $HTTP
echo $EXTENS

if [ $HTTP = 'http' ]
then
    echo ce $EXTENS sur le web!
else
    echo ce $EXTENS en local
fi
