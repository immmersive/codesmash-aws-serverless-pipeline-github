resource "aws_iam_role" "role" {
  name               = "role-${var.cicd_name}-${terraform.workspace}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}