echo -e "\e[31m>>>>>>>>> install golang <<<<<<<<\e[0m"
yum install golang -y

echo -e "\e[31m>>>>>>>>> create application user <<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[31m>>>>>>>>> creating app directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[31m>>>>>>>>> creating download the content <<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app

echo -e "\e[31m>>>>>>>>> extract the app content <<<<<<<<\e[0m"
unzip /tmp/dispatch.zip
cd /app

echo -e "\e[31m>>>>>>>>> download the dependencies <<<<<<<<\e[0m"
go mod init dispatch
go get

echo -e "\e[31m>>>>>>>>> build the software <<<<<<<<\e[0m"
go build
echo -e "\e[31m>>>>>>>>> copy the service file <<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[31m>>>>>>>>> restart the application <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch