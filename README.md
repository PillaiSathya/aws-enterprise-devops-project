# AWS Enterprise DevOps Project

## Overview

This project extends my previous GitOps CI/CD project by deploying a complete production-style DevOps infrastructure on AWS using Terraform, Ansible, Jenkins, Docker, Kubernetes, and GitHub.

The objective is to build an end-to-end cloud-native CI/CD platform that follows Infrastructure as Code (IaC), GitOps principles, automation, monitoring, and security best practices.

---

## Tech Stack

- AWS
- Terraform
- Linux (Ubuntu WSL)
- Git & GitHub
- Jenkins
- Docker
- Kubernetes
- Ansible
- Prometheus
- Grafana

---

## Project Architecture

### Current AWS Infrastructure

```text
                    AWS
                     │
                     ▼
                  VPC
              10.0.0.0/16
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
   Public Subnet 1       Public Subnet 2
    10.0.1.0/24           10.0.2.0/24
          │
          ▼
         EC2
          │
      User Data
          │
          ▼
        Nginx
          │
          ▼
      Custom HTML
          │
          ▼
       HTTP :80
          │
          ▼
       Internet

```

### Target DevOps Architecture

GitHub
   │
   ▼
Jenkins
   │
   ▼
Terraform
   │
   ▼
AWS Infrastructure
   │
   ├── VPC
   ├── Subnets
   ├── Security Groups
   └── EC2
        │
        ▼
      Docker
        │
        ▼
   Kubernetes
        │
        ▼
      ArgoCD
        │
        ▼
   Monitoring
   ├── Prometheus
   └── Grafana

---

## Project Goals

- Build infrastructure using Terraform
- Deploy applications on AWS
- Automate provisioning using Ansible
- Build CI/CD pipeline using Jenkins
- Deploy to Kubernetes
- Implement GitOps with ArgoCD
- Monitor applications using Prometheus & Grafana
- Follow production-level DevOps practices

---

## Current Progress

### AWS Setup
- AWS Account Configured ✅
- Root User MFA Enabled ✅
- IAM Admin User Created ✅
- AWS CLI Installed ✅
- AWS CLI Configured ✅
- AWS CLI Authentication Verified ✅

### Terraform Setup
- Terraform Installed ✅
- Terraform Project Structure Created ✅
- Terraform Initialized (`terraform init`) ✅
- Terraform Provider Configured ✅
- Terraform Configuration Validated (`terraform validate`) ✅
- Terraform State Managed and Verified ✅
- Terraform Outputs Configured ✅

### AWS Networking
- Custom VPC Created Using Terraform ✅
- Terraform State Verified (`terraform state list`) ✅
- Infrastructure Verified (`terraform show`) ✅
- Public Subnet 1 Created ✅
- Public Subnet Verified Using AWS CLI ✅
- Public Subnet 2 Created ✅
- Public Subnet Verified Using AWS CLI ✅
- Internet Gateway Created Using Terraform ✅
- Public Route Table Created ✅
- Route Table Associated with Public Subnets ✅
- Internet Route (0.0.0.0/0) Added ✅
- Web Security Group Created ✅
- HTTP (80) Access Configured ✅
- SSH (22) Access Configured ✅

### EC2 and Web Server

- AWS Key Pair Created Using Terraform ✅
- Amazon Linux 2023 AMI Retrieved Using Terraform Data Source ✅
- EC2 Instance Provisioned Using Terraform ✅
- EC2 Deployed into Public Subnet ✅
- EC2 Public IP Assigned ✅
- SSH Access Verified ✅
- Nginx Installation Automated Using Terraform User Data ✅
- Nginx Service Automatically Enabled and Started ✅
- Custom HTML Application Automatically Deployed ✅
- `user_data_replace_on_change = true` Configured ✅
- EC2 Replacement Through Terraform Verified ✅
- Web Application Verified Using Browser ✅
- Web Application Verified Using `curl` ✅

### Application Verification

The application is currently accessible through the EC2 public IP.

Example verification:

```bash
curl http://13.232.185.188/
```

### Git
- Git Repository Initialized ✅
- Initial Project Commit Completed ✅
- GitHub Repository Updated ✅

---

## Next Milestones

- ⏳ Configure Ansible
- ⏳ Install Jenkins
- ⏳ Deploy Docker Applications
- ⏳ Configure Kubernetes
- ⏳ Implement GitOps using ArgoCD
- ⏳ Configure Prometheus & Grafana

---

## Repository Structure
aws-enterprise-devops-project/
├── terraform/
├── ansible/
├── kubernetes/
├── jenkins/
├── monitoring/
├── diagrams/
├── screenshots/
├── README.md
├── Daily-Progress.md
├── Commands.md
├── Interview-Notes.md
└── Architecture.md
---

## Screenshots

All infrastructure creation screenshots are available in the **screenshots/** directory.

Each major milestone is captured and documented for learning and interview reference.

---

## Author

**Pillai Sathya Sudalai**

DevOps | AWS | Terraform | Linux | Docker | Kubernetes | Jenkins | GitHub