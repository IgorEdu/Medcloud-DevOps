module "service_whois" {
  source = "./modules/service"
  vpc_id = module.vpc.vpc_id
  region = var.aws_region

  is_public = true

  # Service name
  service_name      = "service-whois"
  service_base_path = ["/whois*", "/whois-prod*"]
  # service_base_path-prod = ["/whois-prod*"]
  service_priority = 400
  container_port   = 8080

  service_launch_type = "FARGATE"

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
  cluster_name     = var.cluster_name
  cluster_id       = module.cluster_example.cluster_id
  cluster_listener = module.cluster_example.listener
  cluster_mesh     = module.cluster_example.cluster_mesh

  cluster_service_discovery = module.cluster_example.cluster_service_discovery

  cluster_name-prod = "${var.cluster_name}-prd"
  # cluster_id-prod        = module.cluster_prod.cluster_id
  # cluster_listener-prod  = module.cluster_prod.listener
  # cluster_mesh-prod      = module.cluster_prod.cluster_mesh

  # cluster_service_discovery-prod = module.cluster_prod.cluster_service_discovery


  # Auto Scale Limits
  desired_tasks = 2
  min_tasks     = 2
  max_tasks     = 10

  # Tasks CPU / Memory limits
  desired_task_cpu = 256
  desired_task_mem = 512

  # CPU metrics for Auto Scale
  cpu_to_scale_up         = 30
  cpu_to_scale_down       = 20
  cpu_verification_period = 60
  cpu_evaluation_periods  = 1

  # Pipeline Configuration
  build_image = "aws/codebuild/docker:17.09.0"

  codestar_connector_credentials = var.codestar_connector_credentials
  git_full_repository_id         = "igoredu/microservice-nadave-whois"
  git_repository_branch          = "master"

  # AZ's
  availability_zones = [
    module.vpc.public_subnet_1a,
    module.vpc.public_subnet_1b
  ]
}

module "service_hash" {
  source = "./modules/service"
  vpc_id = module.vpc.vpc_id
  region = var.aws_region

  is_public = true

  # Service name
  service_name      = "service-hash"
  service_base_path = ["/hash*", "/hash-prod*"]
  # service_base_path-prod = ["/hash-prod*"]
  service_priority = 500
  container_port   = 9000

  service_launch_type = "FARGATE"

  service_healthcheck = {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 10
    interval            = 60
    matcher             = "200"
    path                = "/healthcheck"
    port                = 9000
  }

  # Cluster to deploy your service - see in clusters.tf
  cluster_name     = var.cluster_name
  cluster_id       = module.cluster_example.cluster_id
  cluster_listener = module.cluster_example.listener
  cluster_mesh     = module.cluster_example.cluster_mesh

  cluster_service_discovery = module.cluster_example.cluster_service_discovery

  cluster_name-prod = "${var.cluster_name}-prd"
  # cluster_id-prod        = module.cluster_prod.cluster_id
  # cluster_listener-prod  = module.cluster_prod.listener
  # cluster_mesh-prod      = module.cluster_prod.cluster_mesh

  # cluster_service_discovery-prod = module.cluster_prod.cluster_service_discovery

  # Auto Scale Limits
  desired_tasks = 2
  min_tasks     = 2
  max_tasks     = 10

  # Tasks CPU / Memory limits
  desired_task_cpu = 256
  desired_task_mem = 512

  # CPU metrics for Auto Scale
  cpu_to_scale_up         = 30
  cpu_to_scale_down       = 20
  cpu_verification_period = 60
  cpu_evaluation_periods  = 1

  # Pipeline Configuration
  build_image = "aws/codebuild/docker:17.09.0"

  codestar_connector_credentials = var.codestar_connector_credentials
  git_full_repository_id         = "igoredu/microservice-nadave-fake-hasher"
  git_repository_branch          = "master"

  # AZ's
  availability_zones = [
    module.vpc.public_subnet_1a,
    module.vpc.public_subnet_1b
  ]
}


module "service_faker" {
  source = "./modules/service"
  vpc_id = module.vpc.vpc_id
  region = var.aws_region

  is_public = true

  # Service name
  service_name      = "service-faker"
  service_base_path = ["/faker*", "faker-prod*"]
  # service_base_path-prod = ["/faker-prod*"]
  service_priority = 600
  container_port   = 5000

  service_launch_type = "FARGATE"

  service_healthcheck = {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 10
    interval            = 60
    matcher             = "200"
    path                = "/healthcheck"
    port                = 5000
  }

  # Cluster to deploy your service - see in clusters.tf
  cluster_name     = var.cluster_name
  cluster_id       = module.cluster_example.cluster_id
  cluster_listener = module.cluster_example.listener
  cluster_mesh     = module.cluster_example.cluster_mesh

  cluster_service_discovery = module.cluster_example.cluster_service_discovery

  cluster_name-prod = "${var.cluster_name}-prd"
  # cluster_id-prod        = module.cluster_prod.cluster_id
  # cluster_listener-prod  = module.cluster_prod.listener
  # cluster_mesh-prod      = module.cluster_prod.cluster_mesh

  # cluster_service_discovery-prod = module.cluster_prod.cluster_service_discovery

  # Auto Scale Limits
  desired_tasks = 2
  min_tasks     = 2
  max_tasks     = 10

  # Tasks CPU / Memory limits
  desired_task_cpu = 256
  desired_task_mem = 512

  # CPU metrics for Auto Scale
  cpu_to_scale_up         = 30
  cpu_to_scale_down       = 20
  cpu_verification_period = 60
  cpu_evaluation_periods  = 1

  # Pipeline Configuration
  build_image = "aws/codebuild/docker:17.09.0"

  codestar_connector_credentials = var.codestar_connector_credentials
  git_full_repository_id         = "igoredu/microservice-nadave-fake-person"
  git_repository_branch          = "master"

  # AZ's
  availability_zones = [
    module.vpc.public_subnet_1a,
    module.vpc.public_subnet_1b
  ]
}


module "service_integration" {
  source = "./modules/service"
  vpc_id = module.vpc.vpc_id
  region = var.aws_region

  is_public = true

  # Service name
  service_name      = "service-integration"
  service_base_path = ["/integration*", "/integration-prod*"]
  # service_base_path-prod = ["/integration-prod*"]
  service_priority = 700
  container_port   = 9000

  service_launch_type = "FARGATE"

  service_healthcheck = {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 10
    interval            = 60
    matcher             = "200"
    path                = "/healthcheck"
    port                = 9000
  }

  # Cluster to deploy your service - see in clusters.tf
  cluster_name     = var.cluster_name
  cluster_id       = module.cluster_example.cluster_id
  cluster_listener = module.cluster_example.listener
  cluster_mesh     = module.cluster_example.cluster_mesh

  cluster_service_discovery = module.cluster_example.cluster_service_discovery

  cluster_name-prod = "${var.cluster_name}-prd"
  # cluster_id-prod        = module.cluster_prod.cluster_id
  # cluster_listener-prod  = module.cluster_prod.listener
  # cluster_mesh-prod      = module.cluster_prod.cluster_mesh

  # cluster_service_discovery-prod = module.cluster_prod.cluster_service_discovery

  # Auto Scale Limits
  desired_tasks = 2
  min_tasks     = 2
  max_tasks     = 10

  # Tasks CPU / Memory limits
  desired_task_cpu = 256
  desired_task_mem = 512

  # CPU metrics for Auto Scale
  cpu_to_scale_up         = 30
  cpu_to_scale_down       = 20
  cpu_verification_period = 60
  cpu_evaluation_periods  = 1

  # Pipeline Configuration
  build_image = "aws/codebuild/docker:17.09.0"

  codestar_connector_credentials = var.codestar_connector_credentials
  git_full_repository_id         = "igoredu/microservice-nadave-potato"
  git_repository_branch          = "master"

  # AZ's
  availability_zones = [
    module.vpc.public_subnet_1a,
    module.vpc.public_subnet_1b
  ]
}