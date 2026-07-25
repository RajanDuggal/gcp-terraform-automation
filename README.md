# Automated GCP Infrastructure via Terraform & GitHub Actions

An automated, secure CI/CD pipeline built with **Terraform**, **GitHub Actions**, and **Google Cloud Platform (GCP)**. This project provisions cloud infrastructure using keyless authentication via **Workload Identity Federation (OIDC)**.

---

## 🏗️ Architecture & Features

* **Infrastructure as Code (IaC):** Modularized Terraform configuration (`main.tf`, `variables.tf`) targeting regional GCP deployments.
* **Keyless Authentication:** Implements GCP Workload Identity Federation (OIDC) to eliminate stored, long-lived GCP service account keys.
* **Manual Pipeline Triggers:** Workflows are locked behind `workflow_dispatch` to prevent accidental cost generation or untracked deployments.
* **Automated & Manual Lifecycle Management:** Includes separate workflows for automated deployment (`apply`) and explicit teardown (`destroy`).

---

## 🔒 Security & State Management

To prevent secret leaks and maintain state integrity, strict `.gitignore` rules and remote backend state handling are enforced:

* **Secrets & Variables (`*.tfvars`):** Prevented local environment variables and project-specific secrets from entering version control.
* **Terraform Cache (`.terraform/`):** Excluded local provider binaries and initialization artifacts.
* **State Files (`*.tfstate*`):** State is managed remotely in a dedicated GCS bucket to ensure concurrency and state locking.

---

## 🛠️ CI/CD & Operations

### Pipelines
1. **Provision Infrastructure (`terraform.yml`):** Manually triggered pipeline that initializes, validates, plans, and applies Terraform configurations.
2. **Teardown Infrastructure (`terraform-destroy.yml`):** Dedicated manual workflow with an explicit confirmation step (`DESTROY`) to safely decommission resources directly from GitHub.

### Troubleshooting & State Handling
When workflow runs are interrupted or cancelled mid-flight, GCS state locks can persist. Locks are safely cleared using:

```bash
terraform force-unlock <LOCK_ID>
