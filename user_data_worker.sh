#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install epel -y
sudo yum install erlang -y
sudo yum install rabbitmq-server -y
sudo rabbitmq-plugins enable rabbitmq_management
sudo rabbitmqctl start_app
sudo rabbitmqctl stop_app
sudo truncate -s 0  /var/lib/rabbitmq/.erlang.cookie
sudo echo "XAIFUIBJAVHSEZOKOMHD" >>  /var/lib/rabbitmq/.erlang.cookie
sudo systemctl restart rabbitmq-server.service
sudo rabbitmqctl start_app
sudo rabbitmqctl stop_app


# #MASTER_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=TTN-Rabbit-MQ-Master" "Name=instance-state-name,Values=running"  --query 'Reservations[*].Instances[*].{PrivateIP:PrivateIpAddress}' --output text --region ap-south-1)
# sudo rabbitmqctl join_cluster rabbit@ip-$ec2_master_rabbitmq_private_ip
