# Commands Used

---

## AWS CLI

### Verify AWS CLI

```bash
aws --version
```

Displays the installed AWS CLI version.

---

### Configure AWS CLI

```bash
aws configure
```

Configures:

- Access Key
- Secret Key
- Region
- Output format

---

### Verify IAM User

```bash
aws sts get-caller-identity
```

Shows the currently authenticated AWS account and IAM user.

---

### List VPCs

```bash
aws ec2 describe-vpcs --region ap-south-1
```

Displays all VPCs in the Mumbai region.

---

## Terraform

### Initialize Terraform

```bash
terraform init
```

Downloads providers and initializes Terraform.

---

### Validate Configuration

```bash
terraform validate
```

Checks Terraform syntax.

---

### Preview Changes

```bash
terraform plan
```

Shows resources Terraform plans to create.

---

### Create Infrastructure

```bash
terraform apply
```

Creates AWS resources.

---

### Show Terraform Version

```bash
terraform version
```

Displays installed Terraform version.

Append:
## Terraform State

```bash
terraform state list
```

Lists all resources managed by Terraform.

---

```bash
terraform show
```

Displays the current Terraform state and resource attributes.

---

```bash
terraform fmt
```

Formats Terraform configuration files.

---

```bash
terraform validate
```

Validates Terraform syntax.

---

```bash
terraform plan
```

Generates an execution plan showing proposed infrastructure changes.

---

```bash
terraform apply
```

Applies the planned infrastructure changes.

---

```bash
aws ec2 describe-subnets \
--filters "Name=tag:Project,Values=aws-enterprise-devops" \
--region ap-south-1
```

Verifies the created subnet using the AWS CLI.
## Terraform State

```bash
terraform state list
```

Lists all resources managed by Terraform.

---

```bash
terraform show
```

Displays the current Terraform state and resource attributes.

---

```bash
terraform fmt
```

Formats Terraform configuration files.

---

```bash
terraform validate
```

Validates Terraform syntax.

---

```bash
terraform plan
```

Generates an execution plan showing proposed infrastructure changes.

---

```bash
terraform apply
```

Applies the planned infrastructure changes.

---

```bash
aws ec2 describe-subnets \
--filters "Name=tag:Project,Values=aws-enterprise-devops" \
--region ap-south-1
```

Verifies the created subnet using the AWS CLI.

terraform state list

terraform show

terraform plan

terraform apply

aws ec2 describe-subnets \
--filters "Name=tag:Project,Values=aws-enterprise-devops" \
--region ap-south-1
terraform state list

aws ec2 describe-internet-gateways \
--filters "Name=tag:Project,Values=aws-enterprise-devops" \
--region ap-south-1

terraform state list

terraform fmt

terraform validate

terraform plan

terraform apply

aws ec2 describe-route-tables \
--filters "Name=tag:Project,Values=aws-enterprise-devops" \
--region ap-south-1

aws ec2 describe-security-groups \
--filters "Name=tag:Project,Values=aws-enterprise-devops" \
--region ap-south-1 \
--no-cli-pager