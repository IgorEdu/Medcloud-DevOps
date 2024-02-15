
# Microservices Orchestration on ECS

### Complete Microservices Deploy and Orchestration on Amazon ECS using Terraform

Create clusters and services and pipelines on AWS using Terraform.

# How to Deploy

## How to Deploy

### 1) Navigate to path environments

```bash
cd environments\dev
```

### 2) Github CodeStar Connector

* Create a CodeStar Connector on AWS and insert the ARN on the variable "codestar_connector_credentials"

### 3) Terraform

* Create terraform.tfvars file

```hcl
cluster_name                   = "medcloud"
aws_region                     = "us-east-1"
environment                    = "dev"
codestar_connector_credentials = "arn:aws:codestar-connections:us-east-1:<aws_account_id>:connection/d21fae76-3ebf-4955-a475-5248ab45a39d"
```

* Initialize Terraform

```bash
terraform init
```

* Plan our modifications

```bash
terraform plan
```

* Apply the changes on AWS

```bash
terraform apply
```
