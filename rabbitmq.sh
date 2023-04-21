echo -e "\e[34m>>>>>>>>>download the erlang  <<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[34m>>>>>>>>> download rabbitmq server<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[34m>>>>>>>>> install erlang and rabbitmq server <<<<<<<<\e[0m"
yum install erlang rabbitmq-server -y

echo -e "\e[34m>>>>>>>>> start the serviecs <<<<<<<<\e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo -e "\e[34m>>>>>>>>> add the  user and set the permissssions <<<<<<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"