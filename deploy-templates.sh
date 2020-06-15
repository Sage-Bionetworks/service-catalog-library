#!/bin/bash
set -e

# Deploy templates to AWS Admincentral account to share with other projects.
REPO_NAME="${PWD##*/}"
S3_BUCKET=$(aws cloudformation list-exports --query "Exports[?Name=='us-east-1-bootstrap-CloudformationBucket'].Value" --output text)
S3_BUCKET_PATH="$REPO_NAME/$TRAVIS_BRANCH"
S3_BUCKET_URL="s3://$S3_BUCKET/$S3_BUCKET_PATH"

# Clean existing files on S3 bucket
aws s3 rm --recursive $S3_BUCKET_URL/

# Upload dirs and files to S3 bucket
DIRS=$(ls -d */)
for dir in $DIRS
do
  product_templates=$(ls $dir | grep -E "sc-ec2|sc-s3")
  for product_template in product_templates
  do
    aws s3 cp ${dir}/${product_template} $S3_BUCKET_URL/${dir}/${product_template}
  done
  non_product_templates=$(ls $dir | grep -Ev "sc-ec2|sc-s3")
  for non_product_template in non_product_templates
  do
    aws s3 cp ${dir}/${non_product_template} $S3_BUCKET_URL/${dir}/${non_product_template}
  done
done
