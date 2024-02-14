# Customize the Cluster Name
variable "cluster_name" {
  description = "ECS Cluster Name"
}

# Customize your AWS Region
variable "aws_region" {
  description = "AWS Region for the VPC"
}

variable "codestar_connector_credentials" {
  description = "Codestar connector credential ARN"
}