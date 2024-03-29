module "pipeline" {
  source              = "../pipeline"
  cluster_name        = var.cluster_name
  region              = var.region
  app_service_name    = var.service_name
  container_name      = var.service_name
  app_repository_name = var.service_name

  environment = var.environment


  git_full_repository_id = var.git_full_repository_id
  git_repository_branch  = var.git_repository_branch
  repository_url         = aws_ecr_repository.registry.repository_url
  account_id             = data.aws_caller_identity.current.account_id
  vpc_id                 = var.vpc_id
  build_image            = var.build_image

  subnet_ids = var.availability_zones

  #Dependencies
  # service      = aws_ecs_service.service.id
  target_group = aws_alb_target_group.tg.arn

  codestar_connector_credentials = var.codestar_connector_credentials
}