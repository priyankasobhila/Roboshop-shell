echo -e "\e[35m>>>>>>>>> Download nodejs <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[35m>>>>>>>>> install nodejs <<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[35m>>>>>>>>>  adding application <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[35m>>>>>>>>> creating app directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[35m>>>>>>>>> downloading app content <<<<<<<<\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app

echo -e "\e[35m>>>>>>>>> extract app content  <<<<<<<<\e[0m"
unzip /tmp/cart.zip
cd /app

echo -e "\e[35m>>>>>>>>> download the nodejs dependencies <<<<<<<<\e[0m"
npm install

echo -e "\e[35m>>>>>>>>> setup the systemd services <<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/cart.service /etc/systemd/system/cart.service

echo -e "\e[31m>>>>>>>>> start catalogue service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl start cart