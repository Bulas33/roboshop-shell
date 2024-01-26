#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
MONGODB_HOST=mongodb.wonblesst24.online

TIMESTAMP=$(date  +%F-%H-%M-%S)

LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "script started excuting at $TIMESTAMP" &>> $LOGFILE

VALIDATE (){
    if [$1 -ne 0]
    then
       echo -e "$2 ... $R FAILED $N"
    else
       echo -e "$2 ... $G SUCCESS $N"
    
    fi
}

if [ $ID  -ne 0 ]
then

echo -e "$R ERROR:: Please run this script with root access $N" 
     exit 1 # you can give  other than 0

else
    echo "you are root user "

   fi # fi means reverse if indicating condition end

   dnf module disable nodejs -y &>> $LOGFILE

   VALIDATE $? "Disabling Current NodeJS"

   dnf module enable nodejs:18 -y &>> $LOGFILE

   VALIDATE $? "Enabling NodeJS:18"

   dnf install nodejs -y   &>> $LOGFILE

     VALIDATE $? "Installing NodeJS:18"

     useradd roboshop &>> $LOGFILE

      VALIDATE $? "Creating roboshop User"

      mkdir /app &>> $LOGFILE
   
 VALIDATE $? "Creating app directory" 

 curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>> $LOGFILE

  VALIDATE $? "Downloading catalogue applications" 

  cd /app  

 unzip /tmp/catalogue.zip

 VALIDATE $? "Unzipping catalogue" 

 cd /app

 npm install 

 VALIDATE $? "Installing dependincies"

 cp /home/centos/roboshop-shell/catalogue.service to /etc/systemd/system/catalogue.service &>> $LOGFILE                             

VALIDATE $? "Copying catalogue files"

systemctl daemon-reload &>> $LOGFILE  

VALIDATE $?Catalogue daemon reload""

systemctl enable catalogue &>> $LOGFILE  

VALIDATE $? "Enablr catalogue"

systemctl start catalogue &>> $LOGFILE  

VALIDATE $? "Starting catalogue"
 cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
 
 VALIDATE $? "Copyig mongodb repo"

 dnf install mongodb-org-shell -y

 VALIDATE $? "Installing MongoDB client"

 mongo --host $MONGODB_HOST </app/schema/catalogue.js

 VALIDATE $? "Loading catalogue data into MangoDB"


     
     




