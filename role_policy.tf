resource "aws_iam_role_policy" "role_policy" {
  name   = "${var.cicd_name}-${terraform.workspace}" 
  role   = aws_iam_role.role.id
  policy = data.aws_iam_policy_document.policy.json
}