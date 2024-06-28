resource "aws_codebuild_project" "eks" {
  name          = "eks-build-prueba-devops-03"
  description   = "CodeBuild project for EKS deployment"
  service_role  = var.codebuild_role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    environment_variables = [
      {
        name  = "CLUSTER_NAME"
        value = module.eks.cluster_name
      }
    ]
  }

  source {
    type      = "GITHUB"
    location  = "https://github.com/TxusBlack/prueba-devops-03"
    buildspec = "02/terraform/eks/scripts/buildspec.yml"
  }
}
