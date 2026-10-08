module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "6.7.1"

  comment = "${var.environment} CloudFront"

  enabled         = true
  is_ipv6_enabled = true

  aliases = var.aliases

  price_class = "PriceClass_200"

  # --------------------------------------------------
  # VPC Origin
  # --------------------------------------------------


  vpc_origin = {
    internal_alb = {
      name                   = "${var.environment}-internal-alb-vpc-origin"
      arn                    = var.alb_arn
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"

      origin_ssl_protocols = {
        items    = ["TLSv1.2"]
        quantity = 1
      }
    }
  }

  #--------------------------------------------------
  # Origin Access Control
  # No S3 origin
  # --------------------------------------------------

  origin_access_control = {}
  # --------------------------------------------------
  # CloudFront Origin
  # --------------------------------------------------

  origin = {
    internal_alb = {
      domain_name = var.alb_dns_name

      vpc_origin_config = {
        vpc_origin_key = "internal_alb"

        origin_keepalive_timeout = 5
        origin_read_timeout      = 30
      }
    }
  }

  # --------------------------------------------------
  # Default behavior - Frontend
  # --------------------------------------------------

  default_cache_behavior = {
    target_origin_id       = "internal_alb"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = [
      "GET",
      "HEAD",
      "OPTIONS"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    cache_policy_name = "Managed-CachingOptimized"

    compress = true
  }

  # --------------------------------------------------
  # Backend API
  # --------------------------------------------------

  ordered_cache_behavior = [
    {
      path_pattern           = "/api/*"
      target_origin_id       = "internal_alb"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = [
        "GET",
        "HEAD",
        "OPTIONS",
        "PUT",
        "POST",
        "PATCH",
        "DELETE"
      ]

      cached_methods = [
        "GET",
        "HEAD"
      ]

      cache_policy_name = "Managed-CachingDisabled"

      compress = true
    }
  ]

  # --------------------------------------------------
  # WAF
  # --------------------------------------------------

  web_acl_id = var.web_acl_arn

  # --------------------------------------------------
  # SSL
  # --------------------------------------------------

  viewer_certificate = {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  # --------------------------------------------------
  # Geo restriction
  # --------------------------------------------------

  restrictions = {
    geo_restriction = {
      restriction_type = "none"
    }
  }



  # --------------------------------------------------
  # Deployment
  # --------------------------------------------------

  wait_for_deployment = true

  # --------------------------------------------------
  # Tags
  # --------------------------------------------------

  tags = var.tags
}