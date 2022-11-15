module "message_queue" {
  source              = "../"
  security_groups  = ["sg-xxxxxxxxxxxx"]

  ec2_subnet_id = "subnet-xxxxxxxxxxxxxx"
  key_name = "key_name"
  iam_instance_profile = "instance_profile"
  instance_type = "t3.medium"
  disable_api_termination = false
  disable_api_stop        = false

  subnet_ids          = ["subnet-xxxxxxxxxxxxx"]
  apply_immediately = false
  host_instance_type = "mq.t3.micro"
  deployment_mode    = "ACTIVE_STANDBY_MULTI_AZ"
  storage_type = "efs"
  console_access = true
  publicly_accessible = true
  engine_type = "ActiveMQ"
  engine_version = "5.15.14"
  auto_minor_version_upgrade = false
  activemq_username   = "username"
  activemq_password   = "password"
  audit_logs = false
  general_logs = false

  create_aws_activemq     = true
  create_aws_ec2_rabbitmq = false

  common_tags         = {
    "Project"     = "ToTheNew",
    "Environment" = "Non-prod"
  }
  project_name_prefix = "TTN"
}