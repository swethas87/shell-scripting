#!/bin/bash
source ./common-file.sh

check_root

echo "Enter Mysql root password"
read mysqlrootpassword

dnf install mysql-server -y &>>$LOGFILE
validate $? "Installing MySql server"

systemctl enable mysqld &>>$LOGFILE
validate $? "Enabling Mysql server"

systemctl start mysqld &>>$LOGFILE
validate $? "Start Mysql server"

#nature of shell not being idempotency shown below

#validate $? "Setting root password"

#to make this pgm idempotent
mysql -h db.niksantechnologies.com -uroot -p${mysqlrootpassword} -e 'SHOW DATABASES;'
if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ${mysqlrootpassword} &>>$LOGFILE
    validate $? "Mysql Root password setup"
else
    echo -e "Mysql root password already setup .. $Y  SKIPPING $N"
fi
