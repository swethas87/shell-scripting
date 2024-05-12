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

dnf module disable nodejs:18 -y &>>$LOGFILE
validate $? "Disable nodejs 18 version"
dnf module enable nodejs:20 -y &>>$LOGFILE
validate $? "Enable nodejs 20 version"

dnf install nodejs -y &>>$LOGFILE
validate $? "installing nodejs"

id expense
if [ $? -ne 0 ]
then
    useradd expense &>>$LOGFILE
    validate $? "add expense user"
else
    echo -e "user already exists... $R SKIPPING $N"
fi

mkdir -p /app
validate $? "Creating app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>LOGFILE 
validate $? "Downloading the code"

cd /app &>>LOGFILE
rm -rf /app/*
unzip /tmp/backend.zip &>>LOGFILE
validate $? "extract backend code"

npm install &>>LOGFILE
validate $? "Installing nodejs dependencies"

cp /home/ec2-user/shell-scripting/backend.service /etc/systemd/system/backend.service &>>LOGFILE
validate $? "copy backend service"

systemctl daemon-reload &>>LOGFILE
systemctl start backend &>>LOGFILE
systemctl enable backend &>>LOGFILE
validate $? "starting and enabling backend"

dnf install mysql -y &>>LOGFILE
validate $? "validate mysql installation"

mysql -h db.niksantechnologies.com -uroot -p${mysqlrootpassword} < /app/schema/backend.sql &>>LOGFILE
validate $? "load schema"

systemctl restart backend &>>LOGFILE
validate $? "restart backend"
