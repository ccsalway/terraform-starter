variable "aws_default_region" {}
variable "state_bucket_name" {}


locals {
  global = {
    config = {
      aws_default_region = var.aws_default_region
      state_bucket_name  = var.state_bucket_name
      account_access_role_name = "AdminAccessRole"
    }
  }
}
