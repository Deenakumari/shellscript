SOURCE_DIR=/home/ec2-user/app-log

FILE_TO_DELETE=$(find . -name "*.log* -mtime +14)

while IFS= read -r filepath
do  
    rm -rf $filepath
done <<< $ FILE_TO_DELETE
