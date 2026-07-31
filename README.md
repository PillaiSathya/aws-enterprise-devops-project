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

- AWS Account Configured ✅
- IAM User Created ✅
- AWS CLI Configured ✅
- Terraform Installed ✅
- Terraform Initialized ✅
- First AWS VPC Created Using Terraform ✅
