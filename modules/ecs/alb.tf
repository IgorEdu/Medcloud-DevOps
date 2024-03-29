resource "aws_alb" "cluster_alb" {
  name            = format("%s-alb", var.cluster_name)
  subnets         = var.availability_zones
  security_groups = [aws_security_group.alb_sg.id]

  tags = {
    Name        = format("%s-alb", var.cluster_name)
    Environment = var.environment
  }
}

# resource "aws_alb" "cluster_alb-prod" {
#   name            = format("%s-alb", var.cluster_name-prod)
#   subnets         = var.availability_zones
#   security_groups = [aws_security_group.alb_sg.id]

#   tags = {
#     Name        = format("%s-alb", var.cluster_name-prod)
#     Environment = "Production"
#   }
# }