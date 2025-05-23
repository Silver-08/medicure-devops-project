# HealthCare CI/CD Project

## Overview

This project implements CI/CD pipeline using Jenkins, Docker, Kubernetes, Terraform, Ansible, Prometheus, and Grafana.

## Steps to run:

1. Clone repo
2. Update `terraform/main.tf` region and key pair as needed.
3. Update `ansible/inventory` with provisioned IPs after Terraform apply.
4. Add Docker Hub credentials in Jenkins with ID `dockerhub-credentials`.
5. Run Jenkins pipeline:
   - Checkout
   - Build Docker image with JDK 17
   - Push image to Docker Hub
   - Terraform apply to create 3 servers
   - Ansible to configure servers (k8s master, worker, monitoring)
   - Deploy app to Kubernetes
6. Access Prometheus dashboard at `http://<monitoring-server-ip>:9090`
7. Access Grafana dashboard at `http://<monitoring-server-ip>:3000` (default admin/admin)

---

## Notes:

- Terraform and Ansible must be run locally.
- Jenkins needs SSH access or configured credentials to run Ansible and kubectl commands on remote servers.
