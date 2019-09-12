#!/bin/bash -o errexit

[[ -z "$1" || -z "$2" || -z "$3" || $1 == "help" ]] && { echo "Usage: $0 <action> <env> <target> [options]"; exit 1; }

action=$1;env=$2;target=$3;options=${@:4}

[[ ! -d "./env/${env}" ]] && { echo "./env/${env} not found"; exit 1; }
[[ ! -d "./source/${target}" ]] && { echo "./source/${target} not found"; exit 1; }

source ./env/${env}/source.sh

tmp=$(mktemp -d)
trap "rm -rf ${tmp}" EXIT

cp -LR ./env/${env}/ ${tmp}/
cp -LR ./source/${target}/ ${tmp}/

if [[ -d "./modules" ]]; then
    mkdir -p /tmp/tfmodules
    trap "rm -rf /tmp/tfmodules" EXIT
    for d in ./modules/*; do
        [[ -d "$d" ]] && (cd $d; zip -qr /tmp/tfmodules/$(basename $d) .)
    done
fi

pushd ${tmp}

terraform init \
   -backend-config="region=${TF_VAR_aws_default_region}" \
   -backend-config="bucket=${TF_VAR_state_bucket_name}" \
   -backend-config="key=${target}.${TF_VAR_state_file_postfix}.tfstate" \
   -backend-config="dynamodb_table=${TF_VAR_state_dynamodb_table}"

case $1 in
   "remove")
       (set -x; terraform state rm ${options})
       ;;
   *)
       (set -x; terraform ${action} ${options})
       ;;
esac