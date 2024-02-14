
# Microservices Orchestration on ECS

### Complete Microservices Deploy and Orchestration on Amazon ECS using Terraform

Create clusters and services and pipelines on AWS using Terraform.

# How to Deploy

## Navigate to path environments

```bash
cd environments\dev
```

## Edit AWS Configurations

Create terraform.tfvars file

```hcl
cluster_name                   = "medcloud"
aws_region                     = "us-east-1"
environment                    = "dev"
codestar_connector_credentials = "arn:aws:codestar-connections:us-east-1:<aws_account_id>:connection/d21fae76-3ebf-4955-a475-5248ab45a39d"
```

Verify `main.tf`

```hcl
provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}
```

## Creating a cluster

Edit `clusters.tf` file to customize a cluster preferences. Give infos like ALB basic configurations, AZ's and etc.

```hcl
module "cluster_example" {

    source              = "./modules/ecs"
    vpc_id              = module.vpc.vpc_id
    cluster_name        = var.cluster_name

    listener = {
        port     = 8080
        protocol = "HTTP"
        certificate_arn = ""
        ssl_policy      = "" // Default "ELBSecurityPolicy-TLS-1-1-2017-01"
    }

    availability_zones  = [
        module.vpc.public_subnet_1a,
        module.vpc.public_subnet_1b
    ]

}
```

### Output for ecs

```hcl
output "cluster_id" {}

output "alb" {}

output "listener" {}

```

## Create an Service

Edit `services.tf` and customize an service configurations, like Github sources, containers preferences, alb route path and auto scale preferences.

```hcl
module "service_whois" {
    source          = "./modules/service"
    vpc_id          = module.vpc.vpc_id
    region          = var.aws_region

    is_public       = true

    # Service name
    service_name        = "service-whois"
    service_base_path   = "/whois*"
    service_priority    = 400
    container_port      = 8080

    service_healthcheck = {
        healthy_threshold   = 3
        unhealthy_threshold = 10
        timeout             = 10
        interval            = 60
        matcher             = "200"
        path                = "/healthcheck"
        port                = 8080
    }

    # Cluster to deploy your service - see in clusters.tf
    cluster_name        = var.cluster_name
    cluster_id          = module.cluster_example.cluster_id
    cluster_listener    = module.cluster_example.listener
    cluster_mesh        = module.cluster_example.cluster_mesh

    cluster_service_discovery = module.cluster_example.cluster_service_discovery

    # Auto Scale Limits
    desired_tasks   = 2
    min_tasks       = 2
    max_tasks       = 10

    # Tasks CPU / Memory limits
    desired_task_cpu        = 256
    desired_task_mem        = 512

    # CPU metrics for Auto Scale
    cpu_to_scale_up         = 30
    cpu_to_scale_down       = 20
    cpu_verification_period = 60
    cpu_evaluation_periods  = 1

    # Pipeline Configuration
    build_image         = "aws/codebuild/docker:17.09.0"

    git_full_repository_id  = "igoredu/microservice-nadave-whois"
    git_repository_branch   = "master"

    # AZ's
    availability_zones  = [
        module.vpc.public_subnet_1a,
        module.vpc.public_subnet_1b
    ]
}
```

### Enable Container Insights

Just specify a value `true` on `enable_container_insights` parameter. (Default: `false`)

```hcl
module "cluster_example" {
    source              = "./modules/ecs"

    vpc_id              = module.vpc.vpc_id
    cluster_name        = var.cluster_name

    // ...

    enable_container_insights   = true

    // ...
}

```


### Using Fargate Spot (WAITING FOR TERRAFORM PROVIDER)

Just specify a value `FARGATE_SPOT` on `service_launch_type` parameter. (Default: `FARGATE`)

To change this value is necessary recreate a service. This is causes downtime on production.

```hcl
```

## How to Deploy

### 1) Github CodeStar Connector

* Create a CodeStar Connector on AWS and insert the ARN on the variable "codestar_connector_credentials"

### 2) Terraform

* Create terraform.tfvars file

```hcl
cluster_name                   = "medcloud"
aws_region                     = "us-east-1"
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
