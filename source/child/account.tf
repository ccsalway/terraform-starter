resource "aws_organizations_account" "child" {
  name      = local.child.config.account_name
  email     = local.child.config.account_email
  role_name = local.organization.config.admin_role_name

  lifecycle {
    ignore_changes = ["name", "email", "role_name"]
  }
}
