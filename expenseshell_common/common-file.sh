#!/bin/bash
USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"
set -e

failure(){
    echo "failed at $1:$2"
}
trap ' failure ${LINENO} "${BASH_COMMAND}"' ERR

check_root(){
    if [ $USERID -ne 0 ]
    then
        echo "please run this script with root access"
        exit 1
    else
        echo "you are super user"
    fi
}



validate(){
    if [ $1 -ne 0 ]
    then
        echo -e " $2 $R installation failed $N"
        exit 1
    else
        echo -e "$2 $G is a success $N"
    fi
}
