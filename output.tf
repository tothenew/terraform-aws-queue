# output "activemq_id" {
#   value = var.create_aws_activemq && !var.create_aws_ec2_rabbitmq ? aws_mq_broker.activemq[0].id : "undefined"
# }

# output "activemq_url" {
#   value = var.create_aws_activemq && !var.create_aws_ec2_rabbitmq ? aws_mq_broker.activemq[0].instances[0].console_url : "undefined"
# }

# output "activemq_arn" {
#   value = var.create_aws_activemq && !var.create_aws_ec2_rabbitmq ? aws_mq_broker.activemq[0].arn : "undefined"
# }

# output "ec2_master_rabbitmq_private_ip" {
#   value = !var.create_aws_activemq && var.create_aws_ec2_rabbitmq ? aws_instance.ec2_rabbitmq_master[0].private_ip : "undefined"
# }

# output "ec2_worker_rabbitmq_private_ip" {
#   value = !var.create_aws_activemq && var.create_aws_ec2_rabbitmq ? aws_instance.ec2_rabbitmq_worker[0].private_ip : "undefined"
# }

output "security_group_id" {
  value = aws_security_group.rabbit_sg.id
}
