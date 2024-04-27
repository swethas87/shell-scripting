#!/bin/bash
USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log

validate(){
    if [ $1 -ne 0 ]
    then
        echo "installation failed"
        exit 1
    else
        echo "$2 is a success"
    fi
}
if [ $USERID -ne 0 ]
then
    echo "please run this script with root access"
    exit 1
else
    echo "you are super user"
fi
dnf install mysql -y &>> $LOGFILE
validate $? "Installing mysql"

dnf install git -y &>> $LOGFILE
validate $? "Installing git"
