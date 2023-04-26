#!/bin/bash
set -e

# REPO_NAME and BRANCH_NAME passed from GHA env

# Deploy templates to AWS Admincentral account to share with other projects.
S3_BUCKET="bootstrap-awss3cloudformationbucket-19qromfd235z9"    # bucket in org-sagebase-admincentral
S3_BUCKET_PATH="$REPO_NAME/$BRANCH_NAME"
S3_BUCKET_URL="s3://$S3_BUCKET/$S3_BUCKET_PATH"

# Exit if path is empty
if [ -z "$REPO_NAME" ] || [ -z "$BRANCH_NAME" ]; then
  exit 1
fi

# Clean existing files on S3 bucket
aws s3 rm --recursive $S3_BUCKET_URL/

# Upload dirs and files to S3 bucket
DIRS=$(ls -d */)
for dir in $DIRS
do
  aws s3 cp --recursive ${dir} $S3_BUCKET_URL/${dir}
done
