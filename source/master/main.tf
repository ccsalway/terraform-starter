module "master" {
  source = "file:///tmp/tfmodules/master.zip"
  providers = {
    aws.useast1 = "aws.useast1"
  }
  # variables passed to module
  global = local.global
}
