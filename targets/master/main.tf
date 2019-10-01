module "main" {
  source = "file:///tmp/tfmodules/master.zip"
  providers = {
    aws.useast1 = "aws.useast1"
  }
  config = local.config
}
