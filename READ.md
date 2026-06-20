# Terraform Azure SRE Learning Project

This repository is a hands-on Terraform learning project focused on building real-world SRE (Site Reliability Engineering) and DevOps skills using Azure infrastructure.

The goal is to progress from beginner Terraform usage to production-level infrastructure automation, CI/CD, and remote state management.

---

## 🚀 What This Project Covers

- Terraform fundamentals (providers, resources, state)
- Azure Resource Group provisioning
- Modular Terraform architecture
- Variables, outputs, and environment configuration
- Git best practices for infrastructure code
- Real-world troubleshooting scenarios
- Terraform project structuring like production SRE teams

---

## 🏗️ Current Architecture

---

## ☁️ Infrastructure Created

Using Terraform + Azure:

- Azure Resource Group
- Tagged resources (environment, owner)
- Modular reusable infrastructure design

---

## ⚙️ Tools Used

- Terraform
- Azure CLI (`az login`)
- Git & GitHub
- VS Code
- macOS terminal (zsh)
- Azure Subscription

---

## 🧠 Key Learnings

### 1. Terraform Basics
- `terraform init`, `plan`, `apply`, `destroy`
- Resource definitions using HCL
- Providers (AzureRM)
- State management (`terraform.tfstate`)

---

### 2. Modular Architecture
- Root module orchestrates infrastructure
- Child modules define reusable components
- Separation of concerns (SRE best practice)

---

### 3. Variables & Outputs
- Parameterized infrastructure using variables
- Environment flexibility using `terraform.tfvars`
- Outputs for exposing resource attributes

---

### 4. Git Best Practices for Terraform
- Only commit:
  - `.tf` files
  - `.tfvars.example`
  - modules
  - documentation

- NEVER commit:
  - `.terraform/`
  - `terraform.tfstate`
  - provider binaries
  - credentials

---

## 🧪 Real Issues Faced & Fixes

### ❌ Issue 1: GitHub rejected push (209MB file error)

**Error:**

**Cause:**
Terraform provider binaries inside `.terraform/` were accidentally committed.

**Fix:**
- Added `.terraform/` to `.gitignore`
- Removed cached files from Git tracking
- Cleaned repository structure

---

### ❌ Issue 2: `.gitignore` created as folder instead of file

**Error:**

**Cause:**
`.gitignore` was accidentally created as a directory.

**Fix:**
- Deleted incorrect folder
- Recreated `.gitignore` as a file
- Added proper ignore rules

---

### ❌ Issue 3: Git still rejecting push after fixes

**Cause:**
Large `.terraform` files existed in Git commit history.

**Fix:**
- Identified Git history issue
- Planned repository cleanup using proper Git reset / history filtering

---

## 📌 Important Terraform Rules Learned

- `.terraform/` is auto-generated → NEVER commit
- `terraform.tfstate` is sensitive → NEVER commit
- Providers are downloaded per machine → not source code
- Git tracks history, not just current files
- `.gitignore` does NOT remove already committed files

---

## 🧱 Current Status

- Azure provider configured
- Resource group deployed successfully
- Terraform state created
- Git repository initialized
- Modular structure implemented
- GitHub push in progress cleanup phase

---

## 🛣️ Next Steps (Learning Roadmap)

### Phase 2 - Production SRE Skills

- Remote backend (Azure Storage Account)
- State locking
- Azure DevOps CI/CD pipeline
- Service principal authentication
- Multi-environment deployments (dev/prod)
- Terraform workspaces
- Secrets management (Key Vault)

---

### Phase 3 - Advanced SRE

- Kubernetes (AKS) with Terraform
- Monitoring (Azure Monitor / Prometheus)
- Logging pipelines
- Infrastructure scaling strategies
- High availability architecture design

---

## 🎯 Goal

Transform from:

> Terraform beginner → Production-ready SRE/DevOps engineer

---

## 👨‍💻 Author Learning Notes

This project is built as part of a hands-on learning path focused on:

- Real infrastructure automation
- Cloud engineering (Azure)
- DevOps + SRE practices
- CI/CD pipelines
- Production-grade Terraform usage