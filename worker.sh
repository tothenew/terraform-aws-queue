#!/bin/bash
sudo yum update -y
# sudo yum install nc -y
# sudo amazon-linux-extras install epel -y
# sudo yum install erlang -y
wget https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.1/erlang-23.2.1-1.el7.x86_64.rpm
yum localinstall erlang-23.2.1-1.el7.x86_64.rpm -y
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
yum -y install rabbitmq-server
systemctl enable --now rabbitmq-server.service
sudo rabbitmqctl start_app
sudo rabbitmqctl stop_app
sudo truncate -s 0  /var/lib/rabbitmq/.erlang.cookie
sudo echo "XAIFUIBJAVHSEZOKOMHD" >>  /var/lib/rabbitmq/.erlang.cookie
sudo echo "erlang cookied added"

sudo systemctl restart rabbitmq-server.service
sudo rabbitmqctl start_app
sudo rabbitmqctl stop_app
export MASTER_IP="$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${Name}" "Name=instance-state-name,Values=running"  --query 'Reservations[*].Instances[*].{PrivateIP:PrivateIpAddress}' --output text --region ${region})"
echo "$MASTER_IP"
yum install -y nc

while [ $? -eq 0 ]
do
    nc -zv "$MASTER_IP" 4369
    if [ $? -eq 0 ]; then
    echo "Command Executed Successfully"
    export FINAL="$(echo $MASTER_IP | sed 's/\./-/g')"
    echo "$FINAL"
    sudo rabbitmqctl join_cluster "rabbit@ip-$FINAL"
    sudo rabbitmqctl start_app
    sudo rabbitmq-plugins enable rabbitmq_management
    sudo systemctl restart rabbitmq-server.service
    break
else
    echo "Command Failed"
fi
done

${worker_user_data}



