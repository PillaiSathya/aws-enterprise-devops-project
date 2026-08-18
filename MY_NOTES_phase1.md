# I want to create a small production like environment using terraform, automatically configure a web server and eventually connect this infrastructure to a devops CICD workflow

## CHAPTER 1 : I STARTED WITH AWS INFRASTRUCTURE
First, we created our AWS environment using Terraform.

Instead of manually going into AWS Console and clicking:

VPC → Subnet → Internet Gateway → Route Table → Security Group → EC2...

we told Terraform:

"Here is the infrastructure I want. You create it for me."

Our Terraform architecture currently looks roughly like:

                    AWS
                     │
                  VPC
              10.0.0.0/16
                     │
          ┌──────────┴──────────┐
          │                     │
   Public Subnet 1        Public Subnet 2
    10.0.1.0/24             10.0.2.0/24
          │
          │
       EC2
    t3.micro
          │
       Nginx
          │
    Custom Web Page
	
And we also have:

Internet
   │
Internet Gateway
   │
Route Table
   │
Public Subnet
   │
Security Group
   │
EC2

So we weren't just creating an EC2.

We created the network around the EC2.

## CHAPTER 2 -- WHY TERRAFORM?

"Why did you use Terraform?"

You can answer:

"I used Terraform because I wanted to provision AWS infrastructure as code. Instead of manually creating resources through the AWS Console, I can define the infrastructure in version-controlled configuration files. This makes the infrastructure repeatable, consistent, and easier to manage across environments."

That's the real reason.

And because our Terraform code is in GitHub, we have:

Terraform code
      ↓
Git
      ↓
GitHub

So infrastructure changes are version controlled.

## 🟢 Chapter 3 — We created our EC2

Our EC2 is:

Instance type: t3.micro
AMI: Amazon Linux
Region: ap-south-1

And yes — we deliberately use t3.micro because we're working within our AWS free/credit usage.

We don't need a bigger machine for this project.

The goal isn't to demonstrate expensive hardware.

The goal is to demonstrate:

Infrastructure + Automation + DevOps practices.

## 🟢 Chapter 4 — We gave EC2 an SSH key

Terraform needed to tell AWS:

"Allow this public key to be associated with the EC2."

We originally had a project-relative path, but later discovered:

terraform/environments/dev/keys/

didn't actually exist.

Instead, your key exists here:

~/.ssh/aws-key-2
~/.ssh/aws-key-2.pub

So we changed:

public_key = file("/home/sathya/.ssh/aws-key-2.pub")

That allowed Terraform to use your existing public key.

## 🟢 Chapter 5 — Then came the interesting part: Nginx

Initially, the EC2 could be created.

But our goal wasn't:

"Create an empty EC2."

We wanted:

Create EC2 → automatically install Nginx → automatically create website → serve website.

That's where EC2 User Data came in.

We added something like:

#!/bin/bash


set -e


dnf update -y
dnf install -y nginx


systemctl enable nginx
systemctl start nginx

Then we created our HTML page:

<h1>AWS Enterprise DevOps Project</h1>


<h2>Infrastructure Provisioned using Terraform</h2>


<p>EC2 Provisioned using Terraform</p>


<p>Nginx Installed Automatically using User Data</p>


<p>Created by Sathya</p>

So now our workflow became:

Terraform
   ↓
Create EC2
   ↓
EC2 boots
   ↓
User Data executes
   ↓
Install Nginx
   ↓
Start Nginx
   ↓
Create HTML
   ↓
Website available

That's a very important DevOps concept.

## 🟢 Chapter 6 — We discovered an important User Data problem

This was one of the best learning moments.

We changed our User Data.

We expected:

"Terraform will just run the new script on my existing EC2."

But that's not how EC2 User Data normally works.

User Data is primarily a bootstrapping mechanism during instance initialization.

So we added:

user_data_replace_on_change = true

This tells Terraform:

"If User Data changes, replace the EC2 instance."

So Terraform can create a fresh machine and run the new bootstrap script.

## 🔥 Chapter 7 — Then we learned the difference between STOP and DESTROY

This became important today.

We stopped our original EC2:

i-022138cfd9a4d7aa7

AWS showed:

stopped

We thought:

"Tomorrow we can start it again."

And normally, yes — a stopped EC2 can be started again.

But then we ran:

terraform plan

Terraform said:

-/+ destroy and then create replacement

Why?

Terraform saw that the configuration wanted:

associate_public_ip_address = true

while the stopped instance's refreshed state showed:

associate_public_ip_address = false

Terraform considered that a configuration difference requiring replacement.

So Terraform did:

OLD EC2
   ↓
DESTROY
   ↓
NEW EC2
   ↓
User Data runs again
   ↓
Nginx installed

The old instance:

i-022138cfd9a4d7aa7

was gone.

A new instance appeared:

i-0638dc09860fd0889

And it received a new public IP:

13.127.173.187

That's why when you tried:

aws ec2 start-instances \
  --instance-ids i-022138cfd9a4d7aa7

AWS said:

IncorrectInstanceState

because that instance no longer existed as a usable stopped instance — Terraform had destroyed it.

⭐ Important interview distinction

Stop:

EC2 still exists
↓
Can start again

Destroy:

EC2 is deleted
↓
Cannot start it again

That's a concept you should remember very clearly.

## 🟢 Chapter 8 — We proved automation actually worked

After Terraform created:

i-0638dc09860fd0889

we checked:

terraform state show aws_instance.web_server

and saw:

instance_state = "running"
private_ip     = "10.0.1.178"
public_ip      = "13.127.173.187"

Then we tested:

curl http://$(terraform output -raw web_server_public_ip)/

And received:

<h1>AWS Enterprise DevOps Project</h1>


<h2>Infrastructure Provisioned using Terraform</h2>


<p>EC2 Provisioned using Terraform</p>


<p>Nginx Installed Automatically using User Data</p>


<p>Created by Sathya</p>

🔥 This is the important proof.

We didn't manually SSH into the server and install Nginx.

Terraform created the server, and User Data configured it automatically.

That's actual infrastructure automation.

##🟢 Chapter 9 — Then we improved our Terraform code

Originally we had hard-coded values.

For example:

instance_type = "t3.micro"

and:

region = "ap-south-1"

and:

Environment = "dev"
Project     = "aws-enterprise-devops"

This works.

But it's not very reusable.

So we created:

variable "aws_region" {
  default = "ap-south-1"
}
variable "project_name" {
  default = "aws-enterprise-devops"
}
variable "environment" {
  default = "dev"
}
variable "instance_type" {
  default = "t3.micro"
}

Then we changed the infrastructure to use:

region = var.aws_region
instance_type = var.instance_type
Environment = var.environment
Project = var.project_name
💡 Why did we do that?

Because tomorrow we could theoretically have:

dev
staging
production

Instead of changing the actual Terraform code every time, we can provide different variable values.

For example:

dev
instance_type = t3.micro

while production could eventually have:

production
instance_type = something larger

The same Terraform configuration can become reusable.

That's what parameterization means.

## 🟢 Chapter 10 — We validated everything

After changing the variables, we didn't immediately apply.

We followed the Terraform workflow:

terraform fmt
       ↓
terraform validate
       ↓
terraform plan
       ↓
terraform apply

Today we reached:

Success! The configuration is valid.


No changes. Your infrastructure matches the configuration.

That is excellent.

It means:

"My Terraform code is valid, and the real AWS infrastructure currently matches what I've declared."

## 🟢 Chapter 11 — We committed everything to GitHub

We committed today's Terraform improvement:

1bfb3ea
Parameterize Terraform configuration with variables

And pushed it successfully to GitHub.

So our project history now has another meaningful milestone.

## 🟢 Chapter 12 — Finally, we stopped the EC2

Because we're using limited AWS credits/free usage, we don't want to leave the EC2 running unnecessarily.

So we ran:

aws ec2 stop-instances \
  --instance-ids i-0638dc09860fd0889 \
  --region ap-south-1

At the moment it showed:

stopping

That's okay.

After a short time it should become:

stopped
🎯 So where are we TODAY?

Our project currently has:

                GitHub
                   │
                   ▼
             Terraform Code
                   │
                   ▼
              AWS VPC
                   │
          ┌────────┴────────┐
          ▼                 ▼
    Public Subnet 1   Public Subnet 2
          │
          ▼
        EC2
      t3.micro
          │
          ▼
        Nginx
          │
          ▼
      HTML Website

And Terraform has:

✅ VPC
✅ Subnets
✅ Internet Gateway
✅ Route Table
✅ Security Group
✅ Key Pair
✅ EC2
✅ Nginx automation
✅ User Data
✅ Terraform outputs
✅ Terraform variables
✅ Git version control

That's already a solid foundation.

