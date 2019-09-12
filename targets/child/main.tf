module "main" {
  source = "file:///tmp/tfmodules/child.zip"
  providers = {
    aws         = "aws.child"
    aws.useast1 = "aws.useast1"
    aws.master  = "aws"
  }
  # variables passed to module
  global = local.global
  master = local.master
  child  = local.child
}
