#!/bin/bash

[[ -z "$1" || $1 == "help" ]] && { echo "Usage: $0 env"; exit 1; }

env=$1

[[ ! -d "./env/${env}" ]] && { echo "./env/${env} not found"; exit 1; }

source ./env/${env}/source.sh

# create s3 bucket
aws s3api create-bucket --bucket ${TF_VAR_state_bucket_name} \
  --region ${TF_VAR_aws_default_region} \
  --acl private \
  --create-bucket-configuration LocationConstraint=${TF_VAR_aws_default_region}

aws s3api put-bucket-encryption --bucket ${TF_VAR_state_bucket_name} \
  --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'

aws s3api put-bucket-versioning --bucket ${TF_VAR_state_bucket_name} \
  --versioning-configuration 'MFADelete=Disabled,Status=Enabled'

aws s3api put-public-access-block \
  --bucket ${TF_VAR_state_bucket_name} \
  --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

# create dynamodb table
aws dynamodb create-table --table-name ${TF_VAR_state_dynamodb_table} \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=20,WriteCapacityUnits=20
