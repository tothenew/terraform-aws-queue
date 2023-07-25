#!/bin/bash


# --- bash script is not in use --- #
sudo yum update -y
export MASTER_IP="$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${Name}" "Name=instance-state-name,Values=running"  --query 'Reservations[*].Instances[*].{PrivateIP:PrivateIpAddress}' --output text --region ${region})"
echo "$MASTER_IP master">/etc/hosts
yum update -y
sudo amazon-linux-extras install epel -y
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash
sudo yum install rabbitmq-server erlang -y
systemctl enable --now rabbitmq-server.service
sudo truncate -s 0  /var/lib/rabbitmq/.erlang.cookie
sudo echo "XAIFUIBJAVHSEZOKOMHD" >>  /var/lib/rabbitmq/.erlang.cookie
sudo echo "erlang cookied added"
sudo systemctl restart rabbitmq-server.service
sudo rabbitmqctl stop_app
sudo rabbitmqctl reset && sudo rabbitmqctl join_cluster rabbit@master
sudo rabbitmqctl start_app



