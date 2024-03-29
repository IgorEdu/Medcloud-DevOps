variable "cluster_name" {}

# variable "cluster_name-prod" {}

variable "cluster_domain" {
  default = ""
}

variable "capacity_providers" {
  type    = list(any)
  default = ["FARGATE"]
}

variable "enable_container_insights" {
  type    = bool
  default = false
}

variable "vpc_id" {}

variable "listener" {
  type = map(any)
  default = {
    port            = "80"
    certificate_arn = ""
    ssl_policy      = "ELBSecurityPolicy-TLS-1-1-2017-01"
  }
}

variable "availability_zones" {
  type = list(string)
}

variable "environment" {
  type = string
}