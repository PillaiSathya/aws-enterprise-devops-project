# Interview Notes

---

## Terraform

### What is Terraform?

Terraform is an Infrastructure as Code (IaC) tool developed by HashiCorp that allows us to provision and manage cloud infrastructure using configuration files instead of manually creating resources.

---

### What is Infrastructure as Code?

Infrastructure as Code means defining infrastructure in code so it can be version-controlled, automated, and recreated consistently.

---

### What is terraform init?

Initializes the Terraform working directory.

It performs:

- Downloads providers
- Creates .terraform directory
- Creates .terraform.lock.hcl
- Initializes backend (if configured)

---

### What is terraform plan?

Shows what Terraform will create, modify, or destroy without making any changes.

---

### What is terraform apply?

Executes the execution plan and creates or updates infrastructure.

---

### What is terraform.tfstate?

Terraform state file stores the mapping between Terraform configuration and the real infrastructure in AWS.

Without this file Terraform cannot determine what resources already exist.

---

### Why shouldn't terraform.tfstate be committed to GitHub?

Because it contains:

- Resource IDs
- ARNs
- Infrastructure metadata
- Sometimes sensitive information

In enterprise environments it is stored remotely (Amazon S3) with state locking (DynamoDB).

---

### What is .terraform folder?

Contains downloaded provider plugins and module cache.

It can always be recreated using:

terraform init

Therefore it is ignored using .gitignore.

---

### What is a Provider?

A provider is a plugin that allows Terraform to communicate with cloud platforms.

Examples:

- AWS Provider
- Azure Provider
- Google Cloud Provider

---

### What is a Resource?

A resource is any infrastructure component Terraform creates.

Examples:

- EC2
- VPC
- Subnet
- Security Group
- S3 Bucket

## Terraform Resource References

Example:

```hcl
vpc_id = aws_vpc.main.id
```

Terraform automatically retrieves the VPC ID from the created resource and establishes a dependency.

---

## Terraform State

Terraform State maps Terraform configuration to actual infrastructure. It stores resource IDs, attributes, metadata, and dependency information so Terraform can detect infrastructure changes.

---

## Difference Between Default VPC and Custom VPC

Default VPC:
- Created automatically by AWS.
- Includes default subnets, route tables, Internet Gateway, and Security Groups.

Custom VPC:
- Created by users.
- Fully customizable.
- Recommended for production environments.

---

## Public Subnet

A subnet becomes public only when:

- An Internet Gateway is attached to the VPC.
- A Route Table routes `0.0.0.0/0` traffic to the Internet Gateway.

Enabling `map_public_ip_on_launch = true` alone does not make a subnet public.

## Public Subnets

A public subnet is a subnet whose route table contains a route to an Internet Gateway.

In this project:

- Public Subnet 1
  - CIDR: 10.0.1.0/24
  - AZ: ap-south-1a

- Public Subnet 2
  - CIDR: 10.0.2.0/24
  - AZ: ap-south-1b

Both subnets are configured with:

- map_public_ip_on_launch = true

This automatically assigns a public IP address to EC2 instances launched into these subnets.

## Internet Gateway (IGW)

An Internet Gateway enables communication between a VPC and the Internet.

Key points:

- Attached at the VPC level
- Allows inbound and outbound internet connectivity
- Works together with Route Tables
- Public subnets require a route to the Internet Gateway (0.0.0.0/0)

Without an Internet Gateway, resources inside the VPC cannot access the public Internet.

---

## Route Table vs Security Group

### Route Table

- Controls where network traffic goes
- Works at subnet level
- Contains routes
- Example:
  0.0.0.0/0 → Internet Gateway

### Security Group

- Controls what traffic is allowed
- Works at EC2 instance level
- Stateful firewall
- Allows SSH, HTTP, HTTPS etc.

Interview Tip:

Route Table = Path of traffic

Security Group = Permission for traffic

# Session 5 – EC2 Deployment & SSH

## EC2
- EC2 (Elastic Compute Cloud) is a virtual server in AWS.
- It allows us to run applications in the cloud.
- EC2 instances are launched inside a VPC and Subnet.

---

## AWS Key Pair

A Key Pair consists of:

- Public Key (stored in AWS)
- Private Key (stored on local machine)

During instance launch, AWS copies the public key into the EC2 instance.

During SSH login, the private key is used for authentication.

If the private key and public key do not match, SSH authentication fails.

---

## Security Group

Security Groups act as virtual firewalls.

Inbound Rules:
- SSH (22)
- HTTP (80)

Outbound:
- Allow All

Security Groups are Stateful.

---

## SSH Connection

SSH Command:

ssh -i ~/.ssh/aws-key-2 ec2-user@<Public-IP>

Common verification commands:

whoami

hostname

cat /etc/os-release

---

## Terraform Data Source

Terraform Data Sources retrieve existing information from AWS.

Example:

data "aws_ami" "amazon_linux" {
    ...
}

Instead of hardcoding an AMI ID, Terraform automatically retrieves the latest Amazon Linux AMI.

---

## Terraform Replace

If a resource cannot be updated in-place:

terraform apply -replace=RESOURCE_NAME

Example:

terraform apply -replace=aws_instance.web_server

Terraform destroys the old resource and creates a new one.

---

## Real-world Issue Faced

Problem:
SSH authentication failed.

Reason:
The public key uploaded to AWS was different from the private key used locally.

Error:

Permission denied (publickey)

Solution:

- Compared both public keys
- Corrected the Terraform key file
- Recreated AWS Key Pair
- Recreated EC2 Instance
- Successfully connected using SSH

Interview Learning:

Always verify the uploaded public key matches the private key used for authentication.


---

# Interview Notes - August-05

## Why did Terraform want to recreate the EC2 instance?

Terraform uses the latest Amazon Linux AMI through a data source.

Whenever AWS releases a newer AMI, Terraform detects that the AMI ID has changed.

Since the AMI attribute is immutable, Terraform destroys the old EC2 instance and creates a new one.

---

## Why did SSH initially fail?

Terraform created an AWS Key Pair using one public key.

The SSH connection used a different private key.

Because the keys were not a matching pair, authentication failed.

The issue was resolved by:

- generating a new SSH key pair
- updating Terraform to use the new public key
- replacing the AWS Key Pair
- recreating the EC2 instance
- connecting using the matching private key

---

## Amazon Linux 2023

Package Manager
dnf

Default User
ec2-user

Service Manager
systemctl
---

## Commands commonly used during server verification

whoami
hostname
uptime
df -h
free -m
ip addr
ip route
cat /etc/os-release
---

## Nginx

Install
sudo dnf install nginx -y

Start
sudo systemctl start nginx

Enable
sudo systemctl enable nginx

Status
sudo systemctl status nginx

Version
nginx -v

Test locally
curl localhost
---

## Interview Questions

Q. Why enable a service?

To ensure the service automatically starts after every reboot.

---

Q. Difference between start and enable?

start

Starts immediately.

enable

Starts automatically during system boot.

---

Q. Why use curl localhost?

To verify the web server is serving HTTP content locally before testing external connectivity.

---

Q. Why use Terraform?

Infrastructure becomes repeatable, version-controlled, and easily reproducible across environments.