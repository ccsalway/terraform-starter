locals {
  cidr_base = "10.0.0.0/8"
  cidr_blocks = {
    master = {
      cidr_block = cidrsubnet(local.cidr_base, 10, 0)
      newbits    = 3
    }
  }
}
