# Sage Bionetworks AWS Service Catalog Reference Architecture
This reference architecture is based on the original [aws-service-catalog-reference-architectures](https://github.com/aws-samples/aws-service-catalog-reference-architectures) from AWS, but has been heavily customized for Sage Bionetworks.

[AWS Service Catalog](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/introduction.html)
allows you to centrally manage commonly deployed AWS services, and helps you achieve consistent
governance which meets your compliance requirements, while enabling users to quickly deploy only
the approved AWS services they need.

This guide will help you deploy and manage your AWS ServiceCatalog using Infrastructure as Code (IaC).
 Read the [documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-reference-servicecatalog.html) for more information on ServiceCatalog and CloudFormation.

## Deployment
Merges to master will copy these templates to an S3 bucket that is used by [organizations-infra/sceptre/scipool](https://github.com/Sage-Bionetworks-IT/organizations-infra/tree/master/sceptre/scipool) to deploy stacks.

## Develoopment

### Pre-Commit
As a pre-deployment step we syntatically validate our sceptre and
cloudformation yaml files with [pre-commit](https://pre-commit.com).

Please install pre-commit, once installed the file validations will
automatically run on every commit. Alternatively you can manually
execute the validations by running `pre-commit run --all-files`.
Please install pre-commit, once installed the file validations will
automatically run on every commit.

### Functional Testing
In order to test a change to a template, the template to test needs
to be uploaded to S3, and then a service catalog product needs to
be configured to use the test template.

This process has been automated by running the deploy pipeline on
branches that begin with `test/`, which will upload the templates
to S3 in a directory named after the branch name. Automating the
process increases consistency and accuracy of the tests, and
reduces the impact of potential human error.

Once a test template has been uploaded to S3, a PR can be made
to `organizations-infra` to create or update a service catalog
product that references the test template, like in [this PR](https://github.com/Sage-Bionetworks-IT/organizations-infra/pull/1109/files).
This process is outlined [in scipool documentation in `organizations-infra`](https://github.com/Sage-Bionetworks-IT/organizations-infra/tree/master/sceptre/scipool/README.md)
and existing templates can be found in the individual [sceptre templates in `organiationss-infra`](https://github.com/Sage-Bionetworks-IT/organizations-infra/tree/master/sceptre/scipool/config/develop).

### Account and Credentials
While the templates in this library could be used in any AWS account, Sage Bionetworks is currently deploying to the "scipooldev" and "scipoolprod" account.

## License
This project is licensed under the Apache 2.0 license - see the [LICENSE](LICENSE) file for details.
