#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0]
then 
    echo "error:please run this script as root user"
    exit 1
else   
    echo "you are running with root user"
fi

dnf list installed mysql

if [ $? -ne 0]
then
    echo "mysql is not installed...you can do it"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then
        echo "installing mysql....sucess"
    else
        echo "installing mysql is....failure"
        exit 1
    fi    
else
    echo " already mysql is installed...nothing to do"
fi                