unset ISENGARD_PRODUCTION_ACCOUNT
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

profile="$1"
region_override="$2"

if [ ! -z $profile ]; then
  export AWS_ACCESS_KEY_ID=`aws configure get aws_access_key_id --profile $profile`
  export AWS_SECRET_ACCESS_KEY=`aws configure get aws_secret_access_key --profile $profile`
  if [[ -n "$region_override" ]]; then
    export AWS_REGION="$region_override"
  else
    export AWS_REGION=`aws configure get region --profile $profile`
  fi
  export AWS_DEFAULT_REGION=$AWS_REGION
  export ACCOUNT_ID=`aws sts get-caller-identity --query Account --output text`
  echo $AWS_REGION
  aws sts get-caller-identity
fi