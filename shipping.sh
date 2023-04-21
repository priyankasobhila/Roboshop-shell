source common.sh

echo -e "\e[31m>>>>>>>>> install maven  <<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[31m>>>>>>>>> adding application <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[31m>>>>>>>>> creating app directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[31m>>>>>>>>>  downloading app content <<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app

echo -e "\e[31m>>>>>>>>> extract app content <<<<<<<<\e[0m"
unzip /tmp/shipping.zip
cd /app

echo -e "\e[31m>>>>>>>>> download maven dependencies <<<<<<<<\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[31m>>>>>>>>> setup systemd service <<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/shipping.service /etc/systemd/system/shipping.service


echo -e "\e[31m>>>>>>>>> start shipping service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping

echo -e "\e[31m>>>>>>>>> install mysql <<<<<<<<\e[0m"
yum install mysql -y

echo -e "\e[31m>>>>>>>>> load schema <<<<<<<<\e[0m"
mysql -h mysql-dev.priyavenkat.online -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[31m>>>>>>>>> start shipping service <<<<<<<<\e[0m"
systemctl restart shipping