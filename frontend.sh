echo -e "\e[31m>>>>>>>>> install python36 <<<<<<<<\e[0m"
yum install nginx -y

echo -e "\e[31m>>>>>>>>> start the service <<<<<<<<\e[0m"
systemctl start nginx

echo -e "\e[31m>>>>>>>>> copy the configuration file <<<<<<<<\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[31m>>>>>>>>> remove the configuration file <<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[31m>>>>>>>>> download the content <<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[31m>>>>>>>>> copy the roboshop configuration file <<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[31m>>>>>>>>> extract the content <<<<<<<<\e[0m"
unzip /tmp/frontend.zip

echo -e "\e[31m>>>>>>>>> restart the service <<<<<<<<\e[0m"
systemctl restart nginx
systemctl enable nginx

