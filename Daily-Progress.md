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
