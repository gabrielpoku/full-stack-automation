# Automation Project Documentation

---

## Overview

This project aims to automate the deployment of an applications using **Terraform** for cloud infrastructure provisioning and **Ansible** for configuration management. The goal is to set up a fully automated workflow that provisions the necessary infrastructure, deploys the application and monitoring stacks, set up visualizations and grafana dashboards, and configures routing between services using Traefik.

---

## Objectives

- **Provision Infrastructure**: Use Terraform to provision Infrastructure (e.g., VM instance, networking).
- **Automate Application Deployment**: Utilize Ansible to configure the environment and deploy containerized services.
- **Set Up Monitoring**: Deploy Prometheus and Grafana to monitor application health and metrics with dynamic dashboards.
- **Automate Routing**: Configure routing between services with Traefik for seamless service communication.

---

## Project Architecture
<img src=".asset/architect.png">

## Project Structure
```
full-stack-automation/
├── ansible/
│   ├── roles/
│   ├── compose.monitoring.yml.j2
│   ├── compose.yml.j2
│   └── playbook.yml
├── backend/
│   ├── .env (should exist only on server or local machine)
│   └── .env.sample
├── frontend/
│   ├── .env (should exist only on server or local machine)
│   └── .env.sample
├── monitoring/
│   ├── dashboards/
│   ├── dashboard-providers.yml
│   ├── loki-config.yml
│   ├── loki-datasource.yml
│   ├── prometheus-datasource.yml
│   ├── prometheus.yml
│   └── promtail-config.yml
├── terraform/
│   ├── ansible.tf
│   ├── backend.tf
│   ├── ec2.tf
│   ├── dns.tf
│   ├── main.tf
│   ├── output.tf
│   ├── terraform.tfvars (only on server or local machine)
│   ├── variables.tf
│   └── vpc.tf
├── .gitignore
└── POSTGRES_PASSWORD.txt (only on server or local machine)
```

### Deployed Services
---
- **Application Stack**:  
  - **Frontend**: React Application (Dockerized)
  - **Backend**: FastAPI Service (Dockerized)
  - **Database**: PostgreSQL (Dockerized)
  - **Reverse Proxy**: Traefik or Nginx for routing
  
- **Monitoring Stack**:  
  - **Prometheus**: For metrics collection
  - **Grafana**: For data visualization and dashboard creation
  - **cAdvisor**: For container-level metrics
  - **Loki**: For log aggregation
  - **Promtail**: For log collection
  
---

## Technologies

- **Terraform**: Infrastructure as Code tool to provision cloud resources.
- **Ansible**: Configuration management tool used for provisioning and configuring servers.
- **Docker**: Containerization platform used to package the application and monitoring stacks.
- **Traefik**: Reverse proxy for routing traffic between containers.
- **Grafana**: Used to monitor and visualize container-level metrics and logs.  
- **Prometheus**: collection of metrics
- **cAdvisor**: exposes container-level metrics
- **Loki**: log aggregation
- **Promtail**: log collection

---

---
### sensitive Files and environment variables
- **frontend/.env**: Includes env for the frontend. This env is templated to receive the variable value defined in terraform.tfvars
- **backend/.env**: Includes env for the backend. 
- **POSTGRES_PASSWORD.txt**: includes the password for the database. This file is mounted as secret and safely injected into the postgresql container.
**Disclaimer**: Please note this envs and sensitive files should only exits on your server for security concerns. It was only pushed for demo and transparent configurations. Ensure you add these files to your `.gitignore` file.

## Project Setup

### Prerequisites
- Ensure you have terraform and ansible installed on your machine.
- Set up AWS programmatic access.
- create S3 bucket for remote terraform state file management.
- dynamodb table for state locking.
---
### Step 1: Build Docker Images
- clone the application repo
  ```
  git clone https://github.com/automation/monitoring.git
  cd monitoring
  ```
- Build the Docker images for the frontend (React) and backend (FastAPI) applications.
  -  `docker build -t maestrops/frontend:latest .`
  -  `docker build -t maestrops/backend:latest .`
- Login to docker on your terminal
  - `docker login -u maestrops`
- Pushed the images to Docker Hub:
  - `docker push maestrops/frontend:latest`
  - `docker push maestrops/backend:latest`
- remove the cloned repo
---
### Step 2: Set up configuration files
- clone this repo
  ```
  git clone https://github.com/automation/automation.git
  cd automation
  ```
- Edit the terraform.tfvars to your desired configurations
---
### Step 3: Apply Terraform config.
- run the command below
  ```
  terraform plan
  terraform apply --auto-approve
  ```
---
### Step 4: DNS Configuration
- During this automation process, you'll be prompted to create A records, pointing your newly created server IP to your domains.
  - yourdomain.com
  - db.yourdomain.com
  - traefik.yourdomain.com
  - www.yourdomain.com
  - www.db.yourdomain.com
  - www.traefik.yourdomain.com
---
### Step 5: Access your applications and monitoring dashboards
- Access all your applications at their respective domains.
- Login to your grafana to access your dashboards.
  


