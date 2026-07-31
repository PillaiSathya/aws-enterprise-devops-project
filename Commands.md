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
