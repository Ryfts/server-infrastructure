#!/bin/bash

# Prerequisites
[[ ! -x "$(which terraform)" ]] && echo "Couldn't find terraform in your PATH. Please see https://www.terraform.io/downloads.html" && exit 1

if [[ "$AWS_ACCESS_KEY_ID" == "" || "$AWS_SECRET_ACCESS_KEY" == "" ]]; then
  echo "AWS environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY not set!"
  exit 1
fi

# Run terraform to create the resources
terraform destroy -var 'aws_access_key='"$AWS_ACCESS_KEY_ID"'' -var 'aws_secret_key='"$AWS_SECRET_ACCESS_KEY"''

# Output application IP
echo "Destroyed!"
echo
