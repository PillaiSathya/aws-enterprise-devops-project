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
