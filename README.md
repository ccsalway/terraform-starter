Starter layout for Terraform 0.12 projects.

**Setup**  
Modify `./env/<env>/source.sh` file.  
Run `./setup.sh <env>` to create S3 bucket and dynamodb table.

**Usage**  
`Usage: ./action.sh <action> <env> <target> [options]`

**Import an existing organization**  
`./action import dev master module.main.aws_organizations_organization.org <id>`

**Import an existing account**  
`./action import dev child aws_organizations_account.child <id>`

**Apply master**  
`./action apply dev master`
