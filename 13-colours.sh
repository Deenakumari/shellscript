#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then 
    echo -e "$R error: you can run with script as root user $N"
    exit 1
else
    echo "you are running with root user"

VALIDATE(){
    if [ $? -eq 0 ]
    then
        echo "installing $2 is....$G sucess $N"
    else
        echo "installing $2 is....$R failure $N"
        exit 1
    fi
}

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed....you can do it"
    dnf install mysql -y
    VALIDATE $? "mysql"
else
    echo "mysql is already installed... $Y nothing do it $N"
fi

dnf list installed python3

if [ $? -ne 0 ]
then
    echo "python3 is not installed....you can do it"
    dnf install python3 -y
    VALIDATE $? "python3"
else
    echo "python3 is already installed...$Y nothing do it $N"
fi

dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "nginx is not installed....you can do it"
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo "nginx is already installed...$Y nothing do it $N"
fi