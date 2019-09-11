provider "aws" {
  # master
  region  = local.global.config.aws_default_region
  version = "~> 2.21"
}

provider "aws" {
  # used for login alerts
  alias   = "useast1"
  region  = "us-east-1"
  version = "~> 2.21"
}

provider "aws" {
  alias   = "child"
  region  = local.global.config.aws_default_region
  version = "~> 2.21"
  assume_role {
    role_arn    = "arn:aws:iam::${aws_organizations_account.child.id}:role/${local.global.config.org_admin_role_name}"
    external_id = "terraform"
  }
}
