resource "aws_codepipeline" "pipeline" {
  name                      = "${var.cicd_name}-${terraform.workspace}" 
  role_arn                  = "arn:aws:iam::${local.account_id}:role/codesmash_role"

  artifact_store {
    location                = "${var.bucket}"
    type                    = "S3"
  }

  stage {
    name = "Source"

    action {
      name                  = "Source"
      category              = "Source"
      owner                 = "AWS"
      provider              = "CodeStarSourceConnection"
      version               = "1"
      output_artifacts      = ["${var.cicd_name}-${terraform.workspace}"] 

      configuration = { 
        ConnectionArn       = var.connection_arn
        FullRepositoryId    = var.repo_name
        BranchName          = var.repo_branch
      }    
    }
  }

  stage {
    name                    = "Build"

    action {
      name                  = "Build"
      category              = "Build"
      owner                 = "AWS"
      provider              = "CodeBuild"
      input_artifacts       = ["${var.cicd_name}-${terraform.workspace}"] 
      version               = "1"

      configuration = {
        ProjectName         = "${aws_codebuild_project.build.name}"
        }
    }
  }
}
