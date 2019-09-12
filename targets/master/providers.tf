provider "aws" {
  # master
  region  = local.global.config.aws_default_region
  version = "~> 2.21"
}

provider "aws" {
  alias   = "useast1"
  region  = "us-east-1"
  version = "~> 2.21"
}
