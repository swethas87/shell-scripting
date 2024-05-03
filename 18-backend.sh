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

dnf module disable nodejs:18 -y &>>$LOGFILE
validate $? "Disable nodejs 18 version"
dnf module enable nodejs:20 -y &>>$LOGFILE
validate $? "Enable nodejs 20 version"

dnf install nodejs -y &>>$LOGFILE
validate $? "installing nodejs"

id expense
if [ $? -ne 0]
then
    useradd expense &>>$LOGFILE
    validate $? "add expense user"
else
    echo -e "user already exists... $R SKIPPING $N"
fi

mkdir -p /app
validate $? "Creating app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip
cd /app

