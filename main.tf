resource "aws_mq_broker" "AWS-ActiveMQ" {
  count                 = var.create_aws_ActiveMQ && !var.create_aws_ec2_RabbitMQ ? 1 : 0
  broker_name = "${var.project_name_prefix}-Activemq"

  engine_type         = var.engine_type
  engine_version      = var.engine_version
  storage_type        = var.storage_type
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately   = var.apply_immediately
  host_instance_type  = var.host_instance_type
  security_groups     = var.security_groups
  deployment_mode     = var.deployment_mode
  subnet_ids 		    = var.subnet_ids
  publicly_accessible = var.publicly_accessible
  logs {
    audit = var.audit_logs
    general = var.general_logs
  }

  user {
    username = var.ActiveMQ_username
    password = var.ActiveMQ_password
    console_access = var.console_access
  }
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  owners = ["amazon"]
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")
}

resource "aws_instance" "ec2" {
  count                   = !var.create_aws_ActiveMQ && var.create_aws_ec2_RabbitMQ ? 1 : 0
  ami                     = data.aws_ami.amazon-linux-2.id
  instance_type           = var.instance_type
  subnet_id               = var.ec2_subnet_id
  vpc_security_group_ids  = var.security_groups
  key_name                = var.key_name
  iam_instance_profile    = var.iam_instance_profile
  ebs_optimized           = var.ebs_optimized
  disable_api_termination = var.disable_api_termination
  user_data_base64        = base64encode(data.template_file.user_data.rendered)
  source_dest_check       = var.source_dest_check
  disable_api_stop        = var.disable_api_stop

  volume_tags = merge(var.common_tags, tomap({ "Name" : "${var.project_name_prefix}-Rabbit-MQ" }))
  tags        = merge(var.common_tags, tomap({ "Name" : "${var.project_name_prefix}-Rabbit-MQ" }))

  root_block_device {
    delete_on_termination = var.delete_on_termination
    encrypted             = var.encrypted
    volume_size           = var.root_volume_size
    volume_type           = var.volume_type
  }

}