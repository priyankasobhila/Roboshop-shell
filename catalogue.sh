echo -e "\e[31m>>>>>>>>> Download nodejs <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[31m>>>>>>>>> install nodejs <<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[31m>>>>>>>>> adding app <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[31m>>>>>>>>> creating app directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[31m>>>>>>>>> downloading app content <<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[31m>>>>>>>>extract  app content <<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip

cd /app

echo -e "\e[32m>>>>>>>>> installing dependencies <<<<<<<<\e[0m"
npm install

echo -e "\e[31m>>>>>>>>> setup systemd service <<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[31m>>>>>>>>> start catalogue service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

echo -e "\e[31m>>>>>>>>> copy mongodb repo <<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[31m>>>>>>>>> install mongodb client <<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[31m>>>>>>>>> load schema <<<<<<<<\e[0m"
mongo --host mongodb.priyavenkat.online </app/schema/catalogue.js