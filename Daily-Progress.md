# AWS Enterprise DevOps Project - Daily Progress

## Session 1 - Project Initialization

**Date:** 31 July 2026

### Objectives

- Create AWS account
- Configure IAM user
- Install AWS CLI
- Configure AWS CLI
- Install Terraform
- Create project structure
- Initialize Terraform

---

## Completed Tasks

### AWS Setup

- Created AWS Account
- Logged in as Root User
- Configured Root User MFA
- Created IAM Admin User (`sathya-admin`)
- Generated AWS Access Keys
- Configured AWS CLI
- Verified IAM authentication

```bash
aws sts get-caller-identity
```

Successfully authenticated as IAM User.

---

### WSL Setup

- Installed AWS CLI v2
- Verified installation

```bash
aws --version
```

- Configured AWS credentials
- Configured default region as **ap-south-1 (Mumbai)**

---

### Terraform Installation

- Added HashiCorp GPG Key
- Added HashiCorp Repository
- Installed Terraform

Verified installation:

```bash
terraform version
```

Installed Version:

```
Terraform v1.15.8
```

---

### Project Structure

Created project repository:

```
aws-enterprise-devops-project
```

Created folders:

```
terraform/
ansible/
jenkins/
kubernetes/
monitoring/
diagrams/
screenshots/
```

Created documentation files:

```
README.md
Daily-Progress.md
Commands.md
Interview-Notes.md
Architecture.md
```

Created Terraform structure:

```
terraform/
└── environments/
    └── dev/
        ├── provider.tf
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

### Terraform Configuration

Configured:

- AWS Provider
- Terraform Version
- AWS Region (ap-south-1)

Successfully executed:

```bash
terraform init
```

Downloaded AWS Provider.

Successfully executed:

```bash
terraform validate
```

Configuration validated successfully.

---

### Infrastructure Created

Created first AWS resource using Terraform.

Resource:

- AWS VPC

Configuration:

- CIDR: 10.0.0.0/16

Tags:

- Name = aws-enterprise-dev-vpc
- Environment = dev
- Project = aws-enterprise-devops

Executed:

```bash
terraform plan
terraform apply
```

Terraform successfully provisioned the VPC.

Verified using:

```bash
aws ec2 describe-vpcs
```

---

## Concepts Learned

- Infrastructure as Code (IaC)
- Terraform Provider
- Terraform Resource
- Terraform State File
- Terraform Lock File
- AWS CLI Authentication
- VPC Basics
- Git Ignore Best Practices

---

## Next Session

- Understand Variables
- Create Outputs
- Build Public Subnets
- Build Private Subnets
- Internet Gateway
- Route Tables

## Session 2 – Public Subnet Creation

**Date:** 1 August 2026

### Objectives
- Understand Terraform State Refresh
- Learn Terraform Resource Dependencies
- Create First Public Subnet
- Verify Resources using AWS CLI and AWS Console

### Completed Tasks
- Reviewed Terraform State
- Used `terraform show` to inspect managed resources
- Created Public Subnet 1 (10.0.1.0/24)
- Associated subnet with custom VPC
- Enabled automatic public IP assignment
- Verified subnet creation using AWS CLI
- Verified subnet in AWS Console

### Key Learnings
- Terraform automatically refreshes state before planning changes.
- Resources can reference other resources using attributes such as `aws_vpc.main.id`.
- AWS assigns additional attributes like Route Table ID and Network ACL after resource creation.
- A subnet is not truly public until an Internet Gateway and appropriate Route Table are configured.

### Public Subnet 2

- Added second public subnet using Terraform
- CIDR Block: 10.0.2.0/24
- Availability Zone: ap-south-1b
- Enabled Auto Assign Public IP
- Verified using Terraform State
- Verified using AWS CLI
- Verified in AWS Console

Commands Used:

terraform plan
terraform apply
terraform state list
aws ec2 describe-subnets --filters "Name=tag:Project,Values=aws-enterprise-devops" --region ap-south-1

### Internet Gateway

- Created Internet Gateway using Terraform
- Attached Internet Gateway to the custom VPC
- Verified using Terraform State
- Verified using AWS CLI
- Verified in AWS Console

Commands Used:

terraform plan
terraform apply
terraform state list
aws ec2 describe-internet-gateways --filters "Name=tag:Project,Values=aws-enterprise-devops" --region ap-south-1

---

---

## Session 3 – Internet Connectivity

**Date:** 3 August 2026

### Objectives

- Create an Internet Gateway
- Attach the Internet Gateway to the custom VPC
- Understand how VPCs connect to the Internet
- Verify resources using Terraform State, AWS CLI, and AWS Console

### Completed Tasks

- Created Internet Gateway using Terraform
- Attached Internet Gateway to the custom VPC
- Verified Internet Gateway using Terraform State
- Verified Internet Gateway using AWS CLI
- Verified Internet Gateway in AWS Console

### Terraform Resource Added

- aws_internet_gateway

### Commands Used

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
terraform state list

aws ec2 describe-internet-gateways \
--filters "Name=tag:Project,Values=aws-enterprise-devops" \
--region ap-south-1

Learning
A VPC is isolated by default and cannot access the Internet.
An Internet Gateway provides a connection between the VPC and the public Internet.
Creating an Internet Gateway alone does not provide Internet access.
A Route Table must contain a route (0.0.0.0/0) pointing to the Internet Gateway for public connectivity.
Interview Notes

Question: What is an Internet Gateway?

Answer:

An Internet Gateway (IGW) is a highly available AWS-managed component that enables communication between a VPC and the Internet. It is attached to a VPC and is used by Route Tables to forward Internet-bound traffic.
```
## Session 4 – Networking Components

**Date:** 4 August 2026

### Completed Tasks

- Created Public Route Table
- Associated Route Table with Public Subnet 1
- Associated Route Table with Public Subnet 2
- Added Internet Route (0.0.0.0/0)
- Created Web Security Group
- Allowed SSH (22)
- Allowed HTTP (80)
- Verified resources using Terraform State
- Verified resources using AWS CLI
- Verified resources in AWS Console

### Terraform Resources Added

- aws_route_table
- aws_route_table_association
- aws_route
- aws_security_group

### Learning

- Difference between Route Table and Security Group
- How Internet Gateway provides internet connectivity
- Why Route Table Associations are required
- How Security Groups act as virtual firewalls

## Next Session

- Create EC2 Key Pair
- Launch EC2 Instance using Terraform
- Attach Security Group
- Deploy EC2 into Public Subnet 1
- Connect to EC2 using SSH
- Install and verify Nginx Web Server

## Session 5 – EC2 Deployment and SSH Access

Date: 4 August 2026


## Objectives
Create AWS Key Pair using Terraform
Launch Amazon Linux EC2 Instance
Connect to EC2 using SSH
Troubleshoot SSH Authentication
Completed Tasks
Created AWS Key Pair (aws-enterprise-key)
Retrieved latest Amazon Linux 2023 AMI using Terraform Data Source
Launched EC2 Instance (t3.micro) in Public Subnet
Associated Security Group with EC2
Assigned Public IP Address
Verified EC2 creation using Terraform State
Verified EC2 in AWS CLI
Verified EC2 in AWS Console
Successfully connected to EC2 using SSH
Issue Encountered

### SSH connection initially failed with:

Permission denied (publickey)
Root Cause

The public key uploaded to AWS (keys/aws-enterprise-key.pub) did not match the private key used for SSH (~/.ssh/aws-key-2).

Terraform correctly created the AWS Key Pair using the file specified in the configuration, but a different local private key was used for authentication.

### Resolution
Compared both public keys.
Identified the mismatch.
Updated keys/aws-enterprise-key.pub with the correct public key.
Recreated the AWS Key Pair.
Recreated the EC2 instance using:
terraform apply -replace=aws_instance.web_server
Successfully connected to the new EC2 instance via SSH.

## Commands Used
terraform plan
terraform apply

terraform state list

terraform state show aws_key_pair.deployer

aws ec2 describe-instances

aws ec2 describe-key-pairs

ssh -i ~/.ssh/aws-key-2 ec2-user@<public-ip>

whoami
hostname
cat /etc/os-release
Concepts Learned
Terraform Data Sources
AWS Key Pair Management
EC2 Launch Process
SSH Authentication
Public Key vs Private Key
Terraform Resource Replacement (-replace)
Infrastructure Troubleshooting
Importance of Matching SSH Key Pairs

# Day Progress - 05 August 2026

## Objectives
- Verify Terraform-managed EC2 instance
- Connect to EC2 using SSH
- Explore Amazon Linux 2023
- Install and configure Nginx
- Deploy a simple web page

---

## Tasks Completed

### Terraform

- Verified Terraform state

```bash
terraform state list
Confirmed infrastructure resources are managed by Terraform.
Ran Terraform plan.
```
### Observation:

Terraform planned to replace the EC2 instance because the latest Amazon Linux AMI ID had changed.
No infrastructure changes were applied.
EC2

### Retrieved Public IP

aws ec2 describe-instances \
--instance-ids <instance-id> \
--region ap-south-1 \
--query "Reservations[].Instances[].PublicIpAddress"

### Connected using SSH

ssh -i ~/.ssh/aws-key-2 ec2-user@<public-ip>

Verified

whoami
hostname
Amazon Linux Version
uptime
memory
disk usage
network interfaces
routing table
Package Management

Updated packages
- sudo dnf update -y

Installed Nginx
- sudo dnf install nginx -y

Nginx
Verified installation
- nginx -v

Started service
- sudo systemctl start nginx

Checked status
- sudo systemctl status nginx

Enabled automatic startup
- sudo systemctl enable nginx

Verified locally
- curl localhost

Successfully displayed the default Nginx page.

Custom Web Page

Edited

/usr/share/nginx/html/index.html

Created a custom HTML page.

Verified

- curl localhost

Output displayed

AWS Enterprise DevOps Project
Infrastructure Provisioned using Terraform
Provisioned with Terraform
Running on Amazon Linux 2023
Nginx Web Server
Created by Sathya Pillai

### Lessons Learned
Terraform state only tracks infrastructure resources.
Starting a stopped EC2 instance changes only the public IP.
SSH key mismatch occurred because Terraform key pair and local private key were different.
EC2 replacement can occur automatically when using a dynamic AMI data source.
Nginx service must be started and enabled separately.
Amazon Linux 2023 uses DNF instead of YUM.

### Next Steps
Verify browser access on port 80.
Open HTTP access if required.
Automate Nginx installation using Terraform user_data.
Remove manual server configuration.