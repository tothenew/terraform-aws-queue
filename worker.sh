#!/bin/bash

sudo yum update -y
sudo amazon-linux-extras install epel -y
sudo yum install erlang -y
sudo yum install rabbitmq-server -y
sudo rabbitmqctl start_app
sudo rabbitmqctl stop_app
sudo truncate -s 0  /var/lib/rabbitmq/.erlang.cookie
sudo echo "XAIFUIBJAVHSEZOKOMHD" >>  /var/lib/rabbitmq/.erlang.cookie
sudo echo "erlang cookied added"

sudo systemctl restart rabbitmq-server.service
sudo rabbitmqctl start_app
sudo rabbitmqctl stop_app
sleep 5m
MASTER_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=TTN-Rabbit-MQ-Master" "Name=instance-state-name,Values=running"  --query 'Reservations[*].Instances[*].{PrivateIP:PrivateIpAddress}' --output text --region us-east-1)

final="${MASTER_IP//[.]/-}"

echo "${final}"
sudo rabbitmqctl join_cluster rabbit@ip-$final
sudo rabbitmqctl start_app

