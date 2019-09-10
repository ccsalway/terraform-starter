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
  alias  = "my_account"
  region = local.global.config.aws_default_region
  version = "~> 2.21"
  assume_role {
    role_arn    = "arn:aws:iam::${local.account.config.account_id}:role/${local.global.config.account_access_role_name}"
    external_id = "terraform"
  }
}
