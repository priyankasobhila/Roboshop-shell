
echo -e "\e[31m>>>>>>>>> install python36 <<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[31m>>>>>>>>> adding application user <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[31m>>>>>>>>> creating app directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[31m>>>>>>>>> download the content <<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app

echo -e "\e[31m>>>>>>>>> extract the content <<<<<<<<\e[0m"
unzip /tmp/payment.zip
cd /app

echo -e "\e[31m>>>>>>>>> install dependencies <<<<<<<<\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[31m>>>>>>>>> copy the service file <<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/payment.service /etc/systemd/system/payment.service

echo -e "\e[31m>>>>>>>>> restart the service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment