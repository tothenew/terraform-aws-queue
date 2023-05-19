#!/bin/bash

yum update -y
#amazon-linux-extras install epel -y
#yum install erlang -y
#yum install rabbitmq-server -y
wget https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.1/erlang-23.2.1-1.el7.x86_64.rpm
yum localinstall erlang-23.2.1-1.el7.x86_64.rpm -y
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.10.0/rabbitmq-server-3.10.0-1.el8.noarch.rpm
sudo rpm -Uvh rabbitmq-server-3.10.0-1.el8.noarch.rpm
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
rabbitmq-plugins enable rabbitmq_prometheus
sudo systemctl restart rabbitmq-server.service

wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
tar xvfz node_exporter-1.5.0.linux-amd64.tar.gz

# Move Node Exporter binaries
sudo mv node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin/

# Create a system user for Node Exporter
sudo useradd -rs /bin/false node_exporter

# Create a systemd service file for Node Exporter
sudo tee /etc/systemd/system/node_exporter.service << EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF

# Set ownership and permissions
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
sudo chmod +x /usr/local/bin/node_exporter

# Reload systemd and start Node Exporter
sudo systemctl daemon-reload
sudo systemctl start node_exporter

# Enable Node Exporter to start on system boot
sudo systemctl enable node_exporter
sudo systemctl status node_exporter
