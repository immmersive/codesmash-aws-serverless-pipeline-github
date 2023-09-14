data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Allow"
    actions = ["*"]
    resources = ["*"]
  }
}