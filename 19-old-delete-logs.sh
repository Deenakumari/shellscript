#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shellscript-log"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
SOURCE_DIR=/home/ec2-user/app-log

if [ $USERID -ne 0 ]
then
    echo -e " $R error: you can run as root user $N" | tee -a $LOG_FILE
    exit 1
else
    echo "you are running with root user" | tee -a $LOG_FILE
fi


VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is...$G sucess $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is...$R failure $N" | tee -a $LOG_FILE
    fi
}

mkdir -p $LOG_FOLDER
echo "script start excyting at : $(date)" | tee -a $LOG_FILE

FILE_TO_DELETE=$(find $SOURCE_DIR -name "*.log* -mtime +14)

while IFS= read -r filepath
do  
    echo "deleting the file : $filepath
    rm -rf $filepath
done <<< $FILE_TO_DELETE
