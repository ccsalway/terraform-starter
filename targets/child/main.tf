module "main" {
  source = "file:///tmp/tfmodules/child.zip"
  providers = {
    aws         = "aws.child"
    aws.master  = "aws"
    aws.useast1 = "aws.useast1"
  }
  # variables passed to module
  global = local.global
  master = local.master
  child  = local.child
}
