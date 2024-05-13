#!/bin/bash

SOURCE_DIRECTORY=/tmp/app-logs
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

if [ -d $SOURCE_DIRECTORY ]
then
    echo "Source Directory exists"
else
    echo " $R Please make sure $SOURCE_DIRECTORY exists $N "
    exit 1
fi
