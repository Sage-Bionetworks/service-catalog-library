#!/bin/bash
set -ex

# Deploy templates to AWS Admincentral account to share with other projects.
REPO_NAME="${PWD##*/}"
S3_BUCKET=$(aws --profile admincentral-cfservice cloudformation list-exports --query "Exports[?Name=='us-east-1-bootstrap-CloudformationBucket'].Value" --output text)
S3_BUCKET_PATH="$REPO_NAME/$TRAVIS_BRANCH"
S3_BUCKET_URL="s3://$S3_BUCKET/$S3_BUCKET_PATH"

# Clean existing files on S3 bucket
#aws s3 rm --recursive $S3_BUCKET_URL/

# Upload dirs and files to S3 bucket
# DIRS=$(ls -d */)
# for dir in $DIRS
# do
#   aws s3 cp --recursive ${dir} $S3_BUCKET_URL/${dir}
# done

# Upload selected development templates
S3_BUCKET_URL=s3://bootstrap-awss3cloudformationbucket-19qromfd235z9/scipoolprod-sc-lib-infra/master/
templates=(ec2/sc-portfolio-ec2-development.yaml ec2/sc-ec2-linux-jumpcloud-v1.0.0.yaml ec2/sc-ec2-linux-jumpcloud-v1.0.2.yaml ec2/sc-product-ec2-linux-jumpcloud-development.yaml)
#templates=(ec2/sc-product-ec2-linux-jumpcloud-development.yaml ec2/sc-ec2-linux-jumpcloud-v1.0.1.yaml)
for i in "${templates[@]}"
do 
   aws --profile admincentral-cfservice s3 cp $i $S3_BUCKET_URL$i
   #echo $S3_BUCKET_URL$i
done
