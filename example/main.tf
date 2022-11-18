module "message_queue" {
  #source              = "git::https://github.com/Nitintothenew/terraform-aws-queue.git"
  source           = "../"
  ec2_subnet_id = "subnet-0a20be4e3402adca2"
  key_name = "nitin-test"
  vpc_id  = "vpc-0b6c5559741a4361b"
  instance_type = "c4.large"
  kms_key_id              = "85f1d4da-7646-4c0a-bb38-80a43c39573e"
  disable_api_termination = false
  disable_api_stop        = false
  subnet_ids          = ["subnet-0a20be4e3402adca2","subnet-0accc84f2ec96934d"]
  apply_immediately = false
  host_instance_type = "mq.t3.micro"
  deployment_mode    = "ACTIVE_STANDBY_MULTI_AZ"
  storage_type = "efs"
  console_access = true
  publicly_accessible = true
  engine_type = "ActiveMQ"
  engine_version = "5.15.14"
  auto_minor_version_upgrade = false
  activemq_username   = "admin"
  audit_logs = false
  general_logs = false
  worker  = 1
  master  = 1
  create_aws_activemq     = false
  create_aws_ec2_rabbitmq = true
  common_tags         = {
    "Project"     = "ToTheNew",
    "Environment" = "dev"
  }
  project_name_prefix = "TTN"
}
