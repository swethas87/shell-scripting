#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
    echo "please run this script with root access"
    exit 1
else
    echo "you are super user"
fi

for i in $@
do
   echo "Package to install: $i"
done