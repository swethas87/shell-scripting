#!/bin/bash
USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

if [ $USERID -ne 0 ]
then
    echo "please run this script with root access"
    exit 1
else
    echo "you are super user"
fi

validate(){
    if [ $1 -ne 0 ]
    then
        echo -e " $2 $R installation failed $N"
        exit 1
    else
        echo -e "$2 $G is a success $N"
    fi
}

for i in $@
do
   echo "Package to install: $i"
   dnf list installed $i &>>$LOGFILE
   if [ $? -eq 0 ]
   then
        echo -e "$i Already installed..$Y SKIPPING $N"
    else
        echo -e "$i not installed.. $R Need to install $N"
        dnf install $i -y &>>LOGFILE
        validate $? "installation of $i"
    fi
done