data "terraform_remote_state" "master" {
  backend = "s3"
  config = {
    bucket = var.global.config.state_bucket_name
    key    = "master.${var.global.config.state_file_postfix}.tfstate"
    region = var.global.config.aws_default_region
  }
}