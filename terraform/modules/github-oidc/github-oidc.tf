module "github_oidc" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-oidc-provider"
  version = "6.1.1"

  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  tags = var.tags
}


module "github_actions_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.1.1"

  name = "GitHubActions-Terraform-${var.environment}"

  description = "IAM role assumed by GitHub Actions to manage ${var.environment} infrastructure."

  max_session_duration = 3600

  trust_policy_permissions = {
    GitHubActions = {
      principals = [
        {
          type = "Federated"

          identifiers = [
            module.github_oidc.arn
          ]
        }
      ]

      actions = [
        "sts:AssumeRoleWithWebIdentity"
      ]

      condition = [
        {
          test     = "StringEquals"
          variable = "token.actions.githubusercontent.com:aud"

          values = [
            "sts.amazonaws.com"
          ]
        },
        {
          test     = "StringEquals"
          variable = "token.actions.githubusercontent.com:sub"

          values = [
            "repo:hamzasaleemofficial@60598687/progrestore@1395617662:ref:refs/heads/dev"
          ]
        }
      ]
    }
  }

  tags = var.tags
}


resource "aws_iam_role_policy_attachment" "terraform_policy" {
for_each = var.iam_policy_arns

  role       = module.github_actions_role.name
  policy_arn = each.value
}