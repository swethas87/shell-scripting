#!/bin/bash
USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"
echo "Enter Mysql root password"
read -s mysqlrootpassword

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

#nature of shell not being idempotency shown below

#validate $? "Setting root password"

#to make this pgm idempotent
mysql -h db.niksantechnologies.com -uroot -p${mysqlrootpassword} -e 'show databases;'
if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ${mysqlrootpassword} &>>$LOGFILE
    validate $? "Mysql Root password setup"
else
    echo -e "Mysql root password already setup .. $Y  SKIPPING $N"
fi
