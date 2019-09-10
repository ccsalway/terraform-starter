#!/bin/bash

export AWS_PROFILE="default"
export AWS_DEFAULT_REGION="eu-west-1"

export TF_VAR_aws_default_region=${AWS_DEFAULT_REGION}
export TF_VAR_dns_primary_domain="salway.im"
export TF_VAR_state_bucket_name="terraform.${TF_VAR_dns_primary_domain}"
export TF_VAR_state_file_postfix="template"
export TF_VAR_state_dynamodb_table="terraform"
