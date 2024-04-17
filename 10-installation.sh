#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 id]
then 
    echo "Please run this script with root access"
else
    echo "You are super user"
fi

dnf install mysql -y