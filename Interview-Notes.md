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
