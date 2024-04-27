#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
    echo "please run this script with root access"
    exit 1
else
    echo "you are super user"
fi
dnf install mysql -y

if [ $? -ne 0 ]
then
    echo "Mysql installation failed"
    exit 1
fi

dnf install git -y

if [ $? -ne 0 ]
then
    echo "Git installation failed"
    exit 1
fi