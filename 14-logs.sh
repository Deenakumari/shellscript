#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shellscript.log"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=$LOG_FOLDER/$SCRIPT_NAME.log

mkdir -p $LOG_FOLDER
echo "script started at : $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then 
    echo -e "$R error: you can run with script as root user $N" | tee -a $LOG_FILE
    exit 1
else
    echo "you are running with root user" | tee -a $LOG_FILE
fi

VALIDATE(){
    if [ $? -eq 0 ]
    then
        echo "installing $2 is....$G sucess $N" | tee -a $LOG_FILE
    else
        echo "installing $2 is....$R failure $N" | tee -a $LOG_FILE
        exit 1
    fi
}

dnf list installed mysql &>>$LOG_FILE

if [ $? -ne 0 ]
then
    echo "mysql is not installed....you can do it" | tee -a $LOG_FILE
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "mysql"
else
    echo "mysql is already installed... $Y nothing do it $N" | tee -a $LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE

if [ $? -ne 0 ]
then
    echo "python3 is not installed....you can do it" | tee -a $LOG_FILE
    dnf install python3 -y &>>$LOG_FILE
    VALIDATE $? "python3"
else
    echo "python3 is already installed...$Y nothing do it $N" | tee -a $LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE

if [ $? -ne 0 ]
then
    echo "nginx is not installed....you can do it" | tee -a $LOG_FILE
    dnf install nginx -y &>>$LOG_FILE
    VALIDATE $? "nginx"
else
    echo "nginx is already installed...$Y nothing do it $N" | tee -a $LOG_FILE
fi