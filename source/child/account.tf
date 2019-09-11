resource "aws_organizations_account" "child" {
  name      = local.child.config.account_name
  email     = local.child.config.account_email
  role_name = local.global.config.org_admin_role_name
}
