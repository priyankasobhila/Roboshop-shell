echo -e "\e[34m>>>>>>>>> download nodejs <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[34m>>>>>>>>> install nodejs <<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[32m>>>>>>>>> add application user <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[34m>>>>>>>>> create app directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[34m>>>>>>>>> download app content <<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[34m>>>>>>>>> unzip app content <<<<<<<<\e[0m"
unzip /tmp/user.zip
cd /app

echo -e "\e[34m>>>>>>>>> install nodejs dependencies <<<<<<<<\e[0m"
npm install

echo -e "\e[34m>>>>>>>>> copy user systemd file <<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[32m>>>>>>>>> start catalogue service<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl start user

echo -e "\e[32m>>>>>>>>> copy mongodb repo <<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32m>>>>>>>>> install mongod client <<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[32m>>>>>>>>> load schema <<<<<<<<\e[0m"
mongo --host mongodb-dev.priyavenkat.online /app/schema/user.js