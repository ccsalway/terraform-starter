# passed in by env vars (TF_VAR)
variable "aws_default_region" {}
variable "state_bucket_name" {}
variable "state_file_prefix" {}
variable "dns_primary_domain" {}


locals {
  config = {
    global = {
      aws_default_region = var.aws_default_region
      state_bucket_name  = var.state_bucket_name
      state_file_prefix  = var.state_file_prefix
      dns_primary_domain = var.dns_primary_domain
    }
    organization = {
      admin_role_name = "AdminAccessRole"
      service_access_principals = [
        # "cloudtrail.amazonaws.com",
        # "ds.amazonaws.com",
        # "sso.amazonaws.com",
        # "config.amazonaws.com",
      ]
    }
    master = {
      vpc = {
        cidr_block   = local.cidr_blocks.master.cidr_block
        cidr_newbits = 3
      }
    }
    child = {
      account_name  = "child"
      account_email = "awsaccount-child@${var.dns_primary_domain}"
    }
  }
}
