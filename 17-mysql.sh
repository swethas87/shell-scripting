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

dnf install mysql-server -y &>>$LOGFILE
validate $? "Installing MySql server"

systemctl enable mysqld &>>$LOGFILE
validate $? "Enabling Mysql server"

systemctl start mysqld &>>$LOGFILE
validate $? "Start Mysql server"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
validate $? "Setting root password"
