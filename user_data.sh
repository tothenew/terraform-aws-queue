#!/bin/bash

yum update -y
#amazon-linux-extras install epel -y
#yum install erlang -y
#yum install rabbitmq-server -y
wget https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.1/erlang-23.2.1-1.el7.x86_64.rpm
yum localinstall erlang-23.2.1-1.el7.x86_64.rpm -y
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
yum -y install rabbitmq-server
systemctl enable --now rabbitmq-server.service
rabbitmq-plugins enable rabbitmq_management
systemctl enable rabbitmq-server.service
systemctl start rabbitmq-server.service
systemctl stop rabbitmq-server.service
truncate -s 0  /var/lib/rabbitmq/.erlang.cookie
echo "XAIFUIBJAVHSEZOKOMHD" >>  /var/lib/rabbitmq/.erlang.cookie 
systemctl start rabbitmq-server.service
export USERNAME="$(aws ssm get-parameter --name /${environment_name}/rabbit/USERNAME --with-decryption --output text --query Parameter.Value --region ${region})"
echo "$USERNAME"
export PASS="$(aws ssm get-parameter --name /${environment_name}/rabbit/PASSWORD --with-decryption --output text --query Parameter.Value --region ${region})"
echo "$PASS"
sudo rabbitmqctl add_user "$USERNAME" "$PASS"
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
sleep 10s
sudo rabbitmq-plugins enable rabbitmq_management
sudo systemctl restart rabbitmq-server.service
