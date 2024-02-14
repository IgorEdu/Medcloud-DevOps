variable "cluster_name" {
  description = "ECS Cluster Name"
}

variable "aws_region" {
  description = "AWS Region for the VPC"
}

variable "codestar_connector_credentials" {
  description = "Codestar connector credential ARN"
}

variable "environment" {
  type    = string
  default = "dev"
}