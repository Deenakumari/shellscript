#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shellscript.log"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=$LOG_FOLDER/$SCRIPT_NAME.log
PACKAGES=("mysql" "python3" "nginx" "httpd")

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
for package in ${PACKAGES[@]}
do
    dnf list installed $package &>>$LOG_FILE

    if [ $? -ne 0 ]
    then
        echo "$package is not installed....you can do it" | tee -a $LOG_FILE
        dnf install $package &>>$LOG_FILE
        VALIDATE $? "$package"
    else
        echo -e "$package is already installed... $Y nothing do it $N" | tee -a $LOG_FILE
    fi
done

