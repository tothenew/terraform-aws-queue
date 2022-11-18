#!/bin/bash

yum update -y
amazon-linux-extras install epel -y
yum install erlang -y
yum install rabbitmq-server -y
rabbitmq-plugins enable rabbitmq_management
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
systemctl stop rabbitmq-server
truncate -s 0  /var/lib/rabbitmq/.erlang.cookie
echo "XAIFUIBJAVHSEZOKOMHD" >>  /var/lib/rabbitmq/.erlang.cookie 
systemctl start rabbitmq-server
PASS=aws ssm get-parameter --name /$environment_name/rabbit/PASSWORD --output text --query Parameter.Value

sudo rabbitmqctl add_user admin $PASS’
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
sleep 10s
sudo rabbitmq-plugins enable rabbitmq_management
sudo systemctl restart rabbitmq-server
