#!/bin/bash -o errexit

[[ -z "$1" || -z "$2" || $1 == "help" ]] && { echo "Usage: $0 action env [options]"; exit 1; }

action=$1;env=$2;options=${@:3}

[[ ! -d "./env/${env}" ]] && { echo "./env/${env} not found"; exit 1; }
[[ ! -d "./source" ]] && { echo "./source not found"; exit 1; }

tmp=$(mktemp -d)
trap "rm -rf $tmp" EXIT

cp -LR ./env/${env}/ ${tmp}/
cp -LR ./source/ ${tmp}/

pushd $tmp

source ./source.sh

terraform init \
   -backend-config="region=${TF_VAR_aws_default_region}" \
   -backend-config="bucket=${TF_VAR_state_bucket_name}" \
   -backend-config="dynamodb_table=${TF_VAR_state_dynamodb_table}" \
   -backend-config="key=${TF_VAR_state_file_prefix}.${TF_VAR_state_file_name}.tfstate"

case $1 in
   "remove")
       (set -x; terraform state rm ${options})
       ;;
   *)
       (set -x; terraform ${action} ${options})
       ;;
esac