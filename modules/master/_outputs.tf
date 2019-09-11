output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "organization_id" {
  value = aws_organizations_organization.org.id
}