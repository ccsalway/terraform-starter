# passed in by env vars (TF_VAR)
variable "aws_default_region" {}
variable "state_bucket_name" {}
variable "state_file_postfix" {}
variable "dns_primary_domain" {}


locals {
  global = {
    config = {
      aws_default_region = var.aws_default_region
      state_bucket_name  = var.state_bucket_name
      state_file_postfix = var.state_file_postfix
      dns_primary_domain = var.dns_primary_domain
    }
  }
  organization = {
    config = {
      admin_role_name = "AdminAccessRole"
      service_access_principals = [
        # "cloudtrail.amazonaws.com",
        # "ds.amazonaws.com",
        # "sso.amazonaws.com",
        # "config.amazonaws.com",
      ]
    }
  }
  master = {
    config = {
    }
  }
  child = {
    config = {
      account_name  = "child"
      account_email = "ccsalway+aws-child@${var.dns_primary_domain}"
    }
  }
}
