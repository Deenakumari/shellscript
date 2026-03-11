#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "error : run this script as root user"
    exit 1
else
    echo "you are runing with root user"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "installing $2...sucess"
    else
        echo "installing $2...failure"
        exit 1
    fi    
}

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed...you can go head"
    dnf install mysql -y
    VALIDATE $? "mysql"
else
    echo "mysql is already installed...nothing to do"    
fi

dnf list installed python3

if [ $? -ne 0 ]
then
    echo "pthon3 is not installed...you can do it"
    dnf install python3 -y
    VALIDATE $? "python3"
else
    echo "pyhton3 is already installed...nothing to do"
fi

dnf list installed nginx

if [ $? -ne 0 ]
then 
    echo "nginx is not installed...you can do"
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo "already installed nginx...nothing to do"
fi        