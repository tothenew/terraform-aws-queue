# terraform-aws-queue

## Usage

```
module "message_queue" {
  source              = "git::https://github.com/tothenew/terraform-aws-queue.git"
  security_groups  = ["sg-999999999999"]
  ec2_subnet_id = "subnet-99999999999"
  key_name = "tothenew"
  iam_instance_profile = "tothenew"
  instance_type = "t3.medium"
  disable_api_termination = true
  disable_api_stop        = true
  subnet_ids          = ["subnet-99999999999","subnet-99999999999"]
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
    "Environment" = "dev"
  }
  project_name_prefix = "TTN"
}
}
```

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Terraform is [installed](#software-dependencies) on the machine where Terraform is executed.
2. Make sure you had access to launch the resources in aws.

### Software Dependencies
## Terraform
- [Terraform](https://www.terraform.io/downloads.html) >= 1.2.5

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| advanced\_security\_options\_enabled | Advance Security Option to Enable for Authentication | `bool` | `false` | no |
| automated\_snapshot\_start\_hour | AWS elasticsearch snapshot start hour time | `number` | `22` | no |
| availability\_zone\_count | Availability Zone count when zone is enabled | `number` | `2` | no |
| cloudwatch\_logs\_retention | Cloudwatch logs of the AWS Elasticsearch retention period | `number` | `7` | no |
| common\_tags | A map to add common tags to all the resources | `map(string)` | n/a | yes |
| create\_aws\_ec2\_elasticsearch | If you want to create the AWS EC2 instance elasticsearch enable this check | `bool` | `true` | no |
| create\_aws\_elasticsearch | If you want to create the AWS elasticsearch enable this check | `bool` | `false` | no |
| create\_iam\_service\_linked\_role | Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. | `bool` | `false` | no |
| delete\_on\_termination | Delete the volume after the termination of the EC2 | `bool` | `true` | no |
| disable\_api\_stop | Disable API stop means disable instance stop | `bool` | `false` | no |
| disable\_api\_termination | Disable API termination means disable instance termination | `bool` | `false` | no |
| ebs\_optimized | EBS optimized enable | `bool` | `true` | no |
| elasticsearch\_version | AWS Elasticsearch version default is 7.10 which is latest | `string` | `"7.10"` | no |
| iam\_instance\_profile | IAM Profile name for launching the EC2 instance | `string` | `"undefined"` | no |
| instance\_count | Number of node of AWS elasticsearch you want to launch | `number` | `1` | no |
| instance\_type | Instance type of the Server | `string` | n/a | yes |
| key\_name | Key name for launching the EC2 instance | `string` | `"undefined"` | no |
| kms\_key\_id | KMS key ID for creating AWS resources | `string` | n/a | yes |
| master\_user\_name | Username of the security option enabled | `string` | `""` | no |
| master\_user\_password | Password of the security option enabled | `string` | `""` | no |
| project\_name\_prefix | A string value to describe prefix of all the resources | `string` | n/a | yes |
| region | A string value for Launch resources in which AWS Region | `string` | n/a | yes |
| security\_group\_ids | A string value for Security Group ID | `list(string)` | n/a | yes |
| source\_dest\_check | Source destination Check | `bool` | `true` | no |
| subnet\_ids | Subnet Ids where server will be launched | `list(string)` | n/a | yes |
| volume\_encrypted | Volume can be encrypted through this check | `bool` | `true` | no |
| volume\_size | Volume size of the EC2 instance | `number` | `100` | no |
| volume\_type | Volume type for EC2 instance default latest type | `string` | `"gp3"` | no |
| vpc\_id | A string value for VPC ID | `string` | n/a | yes |
| zone\_awareness\_enabled | Zone Awareness enable for multi AZ | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| activemq_id | n/a |
| activemq_url | n/a |
| activemq_arn | n/a |
| ec2_rabbitmq_private_ip | n/a |


