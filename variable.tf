variable "create_aws_ActiveMQ" {
  type    = bool
  default = false
}

variable "create_aws_ec2_RabbitMQ" {
  type    = bool
  default = true
}

variable "project_name_prefix" {
  description = "A string value to describe prefix of all the resources"
  type        = string
}

variable "engine_type" {
  type        = string
  description = "Type of broker engine, `ActiveMQ` or `RabbitMQ`"
  default     = "ActiveMQ"
}

variable "engine_version" {
  type        = string
  description = "The version of the broker engine. See https://docs.aws.amazon.com/amazon-mq/latest/developer-guide/broker-engine.html for more details"
  default     = "5.15.14"
}

variable "storage_type" {
  type        = string
  description = "Type of storage"
  default = "ebs"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Enables automatic upgrades to new minor versions for brokers, as Apache releases the versions"
  default     = false
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "host_instance_type" {
  type        = string
  description = "The broker's instance type. e.g. mq.t2.micro or mq.m4.large"
  default     = "mq.m5.large"
}

variable "security_groups" {
  description = "A string value for Security Group ID"
  type        = list(string)
}

variable "deployment_mode" {
  type        = string
  description = "The deployment mode of the broker. Supported: SINGLE_INSTANCE and ACTIVE_STANDBY_MULTI_AZ"
  default     = "SINGLE_INSTANCE"
}

variable "subnet_ids" {
  description = "The VPC Subnet IDs to launch in"
  type        = list(string)
}

variable "publicly_accessible" {
  type        = bool
  description = "Whether to enable connections from applications outside of the VPC that hosts the broker's subnets"
  default     = true
}

variable "ActiveMQ_username" {
  type        = string
  description = "Admin username"
}

variable "ActiveMQ_password" {
  type        = string
  description = "Admin password"
  sensitive   = true
}

variable "console_access" {
  type        = bool
  description = "Whether to enable console access"
  default = true
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "common_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}

variable "project" {
  type    = string
  default = "test"
}

variable "ec2_subnet_id" {
  description = "The VPC Subnet IDs to launch in"
  type        = string
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3a.medium"
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = true
}

variable "disable_api_stop" {
  description = "If true, enables EC2 Instance Stop Protection."
  type        = bool
  default     = false
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = true
}

variable "source_dest_check" {
  description = "Source destination Check. Used for NAT or VPNs."
  type        = bool
  default     = true
}

variable "delete_on_termination" {
  description = "Whether EBS volume will be deleted when instance gets deleted."
  type        = bool
  default     = true
}

variable "encrypted" {
  description = "Whether EBS volume will be encrypted."
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Root volume size of the EC2 instance"
  type        = number
  default     = 50
}

variable "volume_type" {
  description = "Volume type for EC2 instance default latest type"
  type        = string
  default     = "gp3"
}

