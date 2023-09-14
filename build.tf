resource "aws_codebuild_project" "build" {
  name          = "${var.cicd_name}-${terraform.workspace}"
  description   = "${var.cicd_name}-${terraform.workspace}"
  build_timeout = "60"
  service_role  = "arn:aws:iam::${local.account_id}:role/codesmash_role"

  source {
    type        = "CODEPIPELINE"
    buildspec   = "config/buildspec_${var.repo_branch}.yml"
  }  

  artifacts {
    type        = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-aarch64-standard:2.0"
    type         = "ARM_CONTAINER"
  }
}