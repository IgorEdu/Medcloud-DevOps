variable "cluster_name" {
  description = "The cluster_name"
}

variable "cluster_name-prod" {
  description = "The cluster_name"
}

variable "app_repository_name" {
  description = "ECR Repository name"
}

variable "app_service_name" {
  description = "Service name"
}

variable "git_full_repository_id" {
  description = "Repository of the GitHub"
}

variable "git_repository_branch" {
  description = "Build branch aka Master"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "repository_url" {
  description = "The url of the ECR repository"
}

variable "subnet_ids" {
  type        = list(any)
  description = "Subnet ids"
}

variable "build_image" {}

variable "region" {}

variable "container_name" {
  description = "Container name"
}

variable "account_id" {
  description = "AWS Account ID"
}

# variable "service" {}

variable "target_group" {
  default = null
}

variable "codestar_connector_credentials" {
  description = "codestar_connector_credentials"
  type        = string
}