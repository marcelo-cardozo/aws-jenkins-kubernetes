#!/bin/bash

DEPLOYED=$(aws cloudformation describe-stacks --stack-name "$1" | jq -r '.Stacks | length')

ACTION="create-stack"
if [[ "$DEPLOYED" -eq "1" ]]; then
  ACTION='update-stack'
fi

aws cloudformation "$ACTION" --stack-name "$1" --template-body file://"$2" --parameters file://"$3" --region="$4" --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND

