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

dnf install nginx -y &>>LOGFILE
validate $? "Installing nginx"

systemctl enable nginx &>>LOGFILE
validate $? "Enabling nginx"

systemctl start nginx &>>LOGFILE
validate $? "Starting nginx"

rm -rf /usr/share/nginx/html/* &>>LOGFILE
validate $? "Removing existing content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>LOGFILE
validate $? "Download content"

cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>LOGFILE
validate $? "unzipping front end code"

systemctl restart nginx &>>LOGFILE
validate $? "Restarting Nginx"