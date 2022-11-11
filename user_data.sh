#!/bin/bash
yum update -y
sudo amazon-linux-extras install epel -y
sudo yum install erlang -y
sudo yum install rabbitmq-server -y
sudo rabbitmq-plugins enable rabbitmq_management
sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server