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

## Project Architecture (Planned)

```
GitHub
   │
   ▼
Jenkins
   │
Terraform
   │
AWS Infrastructure
(VPC, Subnets, EC2, Security Groups)
   │
Docker
   │
Kubernetes
   │
ArgoCD
   │
Monitoring
(Prometheus + Grafana)
```

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

### AWS Networking
- Custom VPC Created Using Terraform ✅
- Terraform State Verified (`terraform state list`) ✅
- Infrastructure Verified (`terraform show`) ✅
- Public Subnet 1 Created ✅
- Public Subnet Verified Using AWS CLI ✅

### Git
- Git Repository Initialized ✅
- Initial Project Commit Completed ✅
- GitHub Repository Updated ✅

---

## Next Milestones

- ⏳ Create Public Subnet 2
- ⏳ Create Private Subnet 1
- ⏳ Create Private Subnet 2
- ⏳ Create Internet Gateway
- ⏳ Configure Route Tables
- ⏳ Associate Route Tables
- ⏳ Configure NAT Gateway
- ⏳ Create Security Groups
- ⏳ Launch EC2 Instances
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