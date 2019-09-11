# passed in by env vars (TF_VAR)
variable "aws_default_region" {}
variable "state_bucket_name" {}
variable "dns_primary_domain" {}


locals {
  global = {
    config = {
      output_test         = "return me"
      aws_default_region  = var.aws_default_region
      state_bucket_name   = var.state_bucket_name
      dns_primary_domain  = var.dns_primary_domain
      org_admin_role_name = "AdminAccessRole"
    }
  }
  master = {
    config = {
      # master account variables
    }
  }
  child = {
    config = {
      account_name  = "child"
      account_email = "child@${var.dns_primary_domain}"
    }
  }
}
