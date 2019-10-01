resource "aws_organizations_organization" "org" {
  aws_service_access_principals = var.config.organization.service_access_principals
  feature_set                   = "ALL"
}
