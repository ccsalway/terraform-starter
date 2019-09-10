#!/bin/bash

export AWS_PROFILE="default"
export AWS_DEFAULT_REGION="eu-west-1"

export TF_VAR_aws_default_region=${AWS_DEFAULT_REGION}

export TF_VAR_state_bucket_name="terraform.salway.im"
export TF_VAR_state_dynamodb_table="terraform"
