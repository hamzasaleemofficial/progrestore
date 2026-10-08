module "waf" {
  source  = "terraform-aws-modules/wafv2/aws"
  version = "2.1.0"

  name  = var.waf_name
  scope = "CLOUDFRONT"

  default_action = "allow"

  visibility_config = {
    cloudwatch_metrics_enabled = true
    sampled_requests_enabled   = true
    metric_name                = "${var.waf_name}-metrics"
  }

  rules = {
    common-rule-set = {
      priority        = 1
      override_action = "none"

      statement = {
        managed_rule_group_statement = {
          name        = "AWSManagedRulesCommonRuleSet"
          vendor_name = "AWS"
        }
      }
    }

    rate-limit = {
      priority = 2
      action   = "block"

      statement = {
        rate_based_statement = {
          limit              = var.rate_limit
          aggregate_key_type = "IP"
        }
      }
    }
  }

  tags = var.tags
}