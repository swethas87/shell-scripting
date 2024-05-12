#!/bin/bash
source ./common-file.sh

check_root

echo "Enter Mysql root password"
read mysqlrootpassword

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
