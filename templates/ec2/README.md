# Sage Bionetworks AWS Service Catalog EC2 Reference architecture

This reference architecture creates an AWS Service Catalog Portfolio called "Service Catalog EC2 Reference Architecture" with associated products. The portfolio contains the following products:
* EC2 Linux with docker Integration: Provision an AWS Linux EC2 instance with docker and docker compose.
* Notebook Linux EC2 Instance with Jumpcloud Integration, which builds one EC2 instance using an Ubuntu Bionic-based Rstudio AMI.
* EC2 Windows with Jumpcloud Integration, which builds one EC2 instance using a Windows Server 2019 AMI.

## Logging
These templates have been enhanced with AWS CloudWatch agent integration to monitor both system metrics and Docker container logs.

### CloudWatch Log Groups
The template creates log groups automatically with system Metrics

The CloudWatch agent collects:
- CPU usage (idle, iowait, user, system)
- Memory usage percentage
- Disk usage percentage

### Log Retention

All log groups are configured with a 30-day retention period to manage costs.

### Docker Container Logging

Each Docker container is configured with the `awslogs` logging driver to send logs directly to CloudWatch. The logs are organized by:
- Instance ID as the log stream prefix
- Container name as the log stream suffix

This provides clear separation and easy identification of logs from different containers and instances.
