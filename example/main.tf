module "message_queue" {
  source              = "../"
  security_groups  = ["sg-xxxxxxxxxxxxxxxxx"]

  ec2_subnet_id = "subnet-xxxxxxxxxxxxxxxx"
  key_name = "key_name"
  iam_instance_profile = "instance_profile"
  instance_type = "t3.medium"
  disable_api_termination = false
  disable_api_stop        = false

  subnet_ids          = ["subnet-xxxxxxxxxxxxxxxx"]
  apply_immediately = false
  host_instance_type = "mq.m5.large"
  storage_type = "ebs"
  console_access = true
  publicly_accessible = true
  engine_type = "ActiveMQ"
  engine_version = "5.15.14"
  auto_minor_version_upgrade = false
  ActiveMQ_username   = "admin"
  ActiveMQ_password   = "admin@123admin"

  create_aws_ActiveMQ     = true
  create_aws_ec2_RabbitMQ = false

  common_tags         = {
    "Project"     = "ToTheNew",
    "Environment" = "dev"
  }
  project_name_prefix = "TTN"
}
