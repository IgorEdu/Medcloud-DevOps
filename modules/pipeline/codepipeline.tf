resource "aws_codepipeline" "pipeline" {
  name     = format("%s-%s-pipeline", var.cluster_name, var.app_service_name)
  role_arn = aws_iam_role.codepipeline_role.arn

  depends_on = [aws_s3_bucket.source, aws_codebuild_project.app_build]

  artifact_store {
    location = aws_s3_bucket.source.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source"]
      configuration = {
        FullRepositoryId = var.git_full_repository_id
        BranchName       = var.git_repository_branch
        ConnectionArn    = var.codestar_connector_credentials
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source"]
      output_artifacts = ["imagedefinitions"]

      configuration = {
        ProjectName = format("%s-%s-codebuild", var.cluster_name, var.app_service_name)
      }
    }
  }


  stage {
    name = "Approve"

    action {
      name     = "Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }


  stage {
    name = "Deploy-${var.environment}"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["imagedefinitions"]
      version         = "1"

      configuration = {
        ClusterName = "${var.cluster_name}"
        ServiceName = var.app_service_name
        FileName    = "imagedefinitions.json"
      }
    }
  }

  # stage {
  #   name = "Approve"

  #   action {
  #     name     = "Approval"
  #     category = "Approval"
  #     owner    = "AWS"
  #     provider = "Manual"
  #     version  = "1"
  #   }
  # }

  # stage {
  #   name = "Production"

  #   action {
  #     name            = "Deploy"
  #     category        = "Deploy"
  #     owner           = "AWS"
  #     provider        = "ECS"
  #     input_artifacts = ["imagedefinitions"]
  #     version         = "1"

  #     configuration = {
  #       ClusterName = var.cluster_name
  #       ServiceName = "${var.app_service_name}-prod"
  #       FileName    = "imagedefinitions.json"
  #     }
  #   }
  # }
}