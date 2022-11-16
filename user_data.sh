#!/bin/bash
yum update -y
sudo amazon-linux-extras install epel -y
sudo yum install erlang -y
sudo yum install rabbitmq-server -y
sudo rabbitmq-plugins enable rabbitmq_management
sudo systemctl enable rabbitmq-server
truncate -s 0  /var/lib/rabbitmq/.erlang.cookie
echo "XAIFUIBJAVHSEZOKOMHD" >>  /var/lib/rabbitmq/.erlang.cookie 
sudo systemctl start rabbitmq-server
