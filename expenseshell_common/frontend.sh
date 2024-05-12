#!/bin/bash
source ./common-file.sh

check_root

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

cp /home/ec2user/shell-scripting/expense.conf /etc/nginx/default.d/expense.conf
validate $? "Copy expense conf file"

systemctl restart nginx &>>LOGFILE
validate $? "Restarting Nginx"