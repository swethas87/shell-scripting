#!/bin/bash
USERID=$(id -u)

VALIDATE(){
    echo "Exit status is $1"
    echo "$2"

}
if [ $USERID -ne 0 ]
then
    echo "please run this script with root access"
    exit 1
else
    echo "you are super user"
fi
dnf install mysql -y
validate $? "Installing mysql"

dnf install git -y
validate $? "Installing git"
