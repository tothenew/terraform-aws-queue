#output "activemq_arn" {
#  value = var.create_aws_activemq && !var.create_aws_ec2_rabbitmq ? aws_mq_broker.activemq[0].arn : "undefined"
#}
#
#output "activemq_id" {
#  value = var.create_aws_activemq && !var.create_aws_ec2_rabbitmq ? aws_mq_broker.activemq[0].id : "undefined"
#}

output "activemq_url" {
  value       = try(aws_mq_broker.activemq[0].instances[0].console_url, "")
}

#output "ec2_rabbitmq_private_ip" {
#  value = !var.create_aws_activemq && var.create_aws_ec2_rabbitmq ? aws_instance.ec2_rabbitmq[0].private_ip : "undefined"
#}
#
#output "ec2_rabbitmq_public_ip" {
#  value = !var.create_aws_activemq && var.create_aws_ec2_rabbitmq ? aws_instance.ec2_rabbitmq[0].public_ip : "undefined"
#}