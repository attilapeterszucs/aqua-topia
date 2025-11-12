<div align="center">

# 🌊 Aqua Topia

### HTF 2025 Team 8 Challenge Solution

[![Container Build](https://img.shields.io/badge/Container-Podman-892CA0?style=flat-square&logo=podman&logoColor=white)](https://podman.io/)
[![Automation](https://img.shields.io/badge/Automation-Ansible-EE0000?style=flat-square&logo=ansible&logoColor=white)](https://www.ansible.com/)
[![TLS](https://img.shields.io/badge/TLS-Let's%20Encrypt-003A70?style=flat-square&logo=letsencrypt&logoColor=white)](https://letsencrypt.org/)
[![Security](https://img.shields.io/badge/Security-SELinux-0066CC?style=flat-square&logo=redhat&logoColor=white)](https://www.redhat.com/en/topics/linux/what-is-selinux)
[![License](https://img.shields.io/badge/License-HTF%202025-blue?style=flat-square)](LICENSE)

**A production-ready, security-hardened containerized web application deployment solution**

[Features](#-features) • [Architecture](#-architecture) • [Quick Start](#-quick-start) • [Documentation](#-documentation) • [Team](#-team)

---

</div>

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Architecture](#-architecture)
- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start)
- [Project Structure](#-project-structure)
- [Deployment Guide](#-deployment-guide)
- [Configuration](#-configuration)
- [Security](#-security)
- [Monitoring & Health Checks](#-monitoring--health-checks)
- [Troubleshooting](#-troubleshooting)
- [Team](#-team)

---

## 🌟 Overview

**Aqua Topia** is Team 8's comprehensive solution for the HTF 2025 challenge, demonstrating enterprise-grade infrastructure automation and secure application deployment practices. The project showcases a fully automated deployment pipeline for a containerized web application with production-ready security configurations.

### What We're Building

A complete infrastructure automation solution that:
- 🚀 Deploys containerized applications using rootless Podman
- 🔐 Implements TLS/SSL encryption with automatic certificate management
- 🔥 Configures advanced firewall rules for network security
- 🛡️ Enforces SELinux policies for mandatory access control
- 🤖 Automates deployment with Ansible playbooks
- 📊 Provides health monitoring and automatic service recovery

---

## ✨ Features

### 🏗️ Infrastructure as Code
- **Ansible Automation**: Complete infrastructure provisioning and configuration management
- **Idempotent Playbooks**: Safe to run multiple times without side effects
- **Role-Based Organization**: Modular design for bastion and webserver configurations
- **Inventory Management**: Multi-environment support with centralized configuration

### 🐳 Container Orchestration
- **Rootless Podman**: Enhanced security through unprivileged container execution
- **Multi-Stage Builds**: Optimized container images with minimal attack surface
- **Systemd Integration**: Native Linux service management for containers
- **Health Checks**: Automatic monitoring and restart on failure

### 🔒 Security Hardening
- **TLS 1.3 Encryption**: Modern cryptographic protocols with Mozilla security profiles
- **Let's Encrypt Integration**: Automated certificate provisioning and renewal
- **Firewalld Configuration**: Zone-based network security with rich rules
- **SELinux Enforcement**: Mandatory access control for container isolation
- **Non-Root Execution**: Principle of least privilege throughout the stack

### 🔄 Automation & Deployment
- **One-Command Deployment**: Complete stack deployment with single playbook execution
- **Continuous Integration**: Automated container build and registry push
- **Zero-Downtime Updates**: Rolling updates with health verification
- **Automated Backups**: Certificate and configuration backup strategies

---

## 🏛️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    HTF 2025 Network                         │
│                   Subnet: 10.1.8.0/24                       │
└─────────────────────────────────────────────────────────────┘
                           │
           ┌───────────────┴───────────────┐
           │                               │
┌──────────▼──────────┐         ┌─────────▼──────────┐
│   Bastion Host      │         │  Webserver Host    │
│  10.1.8.4           │────────>│  10.1.8.5          │
│                     │   SSH   │                    │
│ ┌─────────────────┐ │         │ ┌────────────────┐ │
│ │   Podman Build  │ │         │ │   Nginx Proxy  │ │
│ │   & Registry    │ │         │ │   (Port 443)   │ │
│ └─────────────────┘ │         │ └────────┬───────┘ │
│ ┌─────────────────┐ │         │          │         │
│ │   Git & CI/CD   │ │         │ ┌────────▼───────┐ │
│ │   Tools         │ │         │ │ Podman Container│ │
│ └─────────────────┘ │         │ │  (Port 8080)   │ │
└─────────────────────┘         │ │                │ │
                                │ │  Aqua Topia    │ │
                                │ │  Application   │ │
                                │ └────────────────┘ │
                                │                    │
                                │ ┌────────────────┐ │
                                │ │  Firewalld     │ │
                                │ │  SELinux       │ │
                                │ │  Let's Encrypt │ │
                                │ └────────────────┘ │
                                └────────────────────┘
```

### Component Overview

| Component | Purpose | Technology |
|-----------|---------|------------|
| **Bastion Host** | Build environment and deployment controller | Podman, Buildah, Ansible |
| **Webserver Host** | Production application server | RHEL 9, Systemd, Podman |
| **Container Registry** | Image storage and distribution | Quay.io |
| **Application** | Web service endpoint | Node.js, HTTP Server |
| **TLS Termination** | SSL/TLS encryption | Let's Encrypt, Certbot |
| **Firewall** | Network security | Firewalld with rich rules |
| **MAC Security** | Access control | SELinux enforcing mode |

---

## 📦 Prerequisites

### System Requirements

**Bastion Host:**
- RHEL/CentOS 9 or compatible
- Podman 4.0+
- Ansible 2.14+
- 2 CPU cores, 2GB RAM minimum
- 20GB free disk space

**Webserver Host:**
- RHEL/CentOS 9 or compatible
- Podman 4.0+
- Systemd 252+
- 2 CPU cores, 2GB RAM minimum
- 10GB free disk space
- Public IP address or domain name

### Network Requirements
- SSH access between bastion and webserver
- Ports 80, 443, 8080 accessible
- DNS records configured for domain
- Subnet: 10.1.8.0/24

### Required Tools
```bash
# On Bastion
- podman
- buildah
- skopeo
- ansible
- git
- openssh-clients

# On Webserver
- podman
- firewalld
- certbot
- policycoreutils-python-utils
```

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/attilapeterszucs/aqua-topia.git
cd aqua-topia
```

### 2. Configure Inventory

Edit `ansible/inventory.ini`:
```ini
[bastion]
bastion8.htf25.qubr.be ansible_host=10.1.8.4

[webserver]
www8.htf25.qubr.be ansible_host=10.1.8.5
```

### 3. Customize Variables

Edit `ansible/group_vars/all.yml`:
```yaml
team_number: 8
domain: "www8.htf25.qubr.be"
certbot_email: "team8@htf25.qubr.be"
```

### 4. Deploy Everything

```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```

### 5. Verify Deployment

```bash
# Check application status
ansible-playbook -i inventory.ini playbook.yml --tags verify

# Test application endpoint
curl https://www8.htf25.qubr.be
```

---

## 📁 Project Structure

```
aqua-topia/
├── ansible/                      # Automation playbooks
│   ├── ansible.cfg              # Ansible configuration
│   ├── inventory.ini            # Host inventory
│   ├── playbook.yml             # Main deployment playbook
│   ├── group_vars/
│   │   └── all.yml              # Global variables
│   └── roles/
│       ├── bastion/             # Bastion host configuration
│       │   ├── tasks/
│       │   │   └── main.yml
│       │   └── handlers/
│       │       └── main.yml
│       └── webserver/           # Webserver configuration
│           ├── tasks/
│           │   └── main.yml
│           └── handlers/
│               └── main.yml
├── container/                    # Container definitions
│   ├── Containerfile            # Multi-stage container build
│   └── build-push.sh            # Build automation script
├── systemd/                      # Service definitions
│   └── aqua-topia-app.service  # Systemd unit file
├── certbot/                      # TLS configuration
│   ├── setup-certbot.yml        # Certificate automation
│   └── mozilla-tls-config.conf  # Modern TLS settings
├── firewalld/                    # Firewall rules
│   └── configure-firewalld.yml  # Security policies
└── README.md                     # This file
```

---

## 🛠️ Deployment Guide

### Step-by-Step Deployment

#### 1. Prepare Bastion Host

```bash
# Run bastion configuration
ansible-playbook -i inventory.ini playbook.yml --tags bastion

# Verify bastion setup
ansible bastion -i inventory.ini -m shell -a "podman version"
```

#### 2. Build Container Image

```bash
# On bastion host
cd container
./build-push.sh latest

# Verify image
podman images | grep aqua-topia
```

#### 3. Configure Webserver

```bash
# Run webserver configuration
ansible-playbook -i inventory.ini playbook.yml --tags webserver

# Check service status
ansible webserver -i inventory.ini -b -a "systemctl --user status aqua-topia-app"
```

#### 4. Setup TLS Certificates

```bash
# Request Let's Encrypt certificate
ansible-playbook -i inventory.ini certbot/setup-certbot.yml

# Verify certificate
ansible webserver -i inventory.ini -b -a "certbot certificates"
```

#### 5. Configure Firewall

```bash
# Apply firewall rules
ansible-playbook -i inventory.ini firewalld/configure-firewalld.yml

# Verify rules
ansible webserver -i inventory.ini -b -a "firewall-cmd --list-all"
```

### Selective Deployment

```bash
# Deploy only specific components
ansible-playbook playbook.yml --tags "bastion"
ansible-playbook playbook.yml --tags "webserver"
ansible-playbook playbook.yml --tags "firewall"
ansible-playbook playbook.yml --tags "tls"

# Skip specific components
ansible-playbook playbook.yml --skip-tags "certbot"
```

---

## ⚙️ Configuration

### Environment Variables

The application supports the following environment variables:

| Variable | Description | Default |
|----------|-------------|---------|
| `TEAM_NUMBER` | Team identifier | `8` |
| `APP_PORT` | Application port | `8080` |
| `NODE_ENV` | Node environment | `production` |
| `SUBNET` | Network subnet | `10.1.8.0/24` |

### Systemd Service Configuration

Located at: `~/.config/systemd/user/aqua-topia-app.service`

```ini
# Restart policy
Restart=always
RestartSec=10

# Resource limits
MemoryLimit=1G
CPUQuota=200%

# Health check
--health-interval=30s
--health-timeout=3s
--health-retries=3
```

### Container Build Configuration

The `Containerfile` uses a multi-stage build:

1. **Builder Stage**: UBI 9 with build tools
2. **Runtime Stage**: UBI Minimal for reduced attack surface

Key features:
- Non-root user (UID 1001)
- OpenShift compatible
- Layer caching for faster builds
- Health check endpoint at `/health`

---

## 🔐 Security

### Security Features

#### 1. TLS/SSL Encryption
- **Protocol**: TLS 1.3 only
- **Certificate Authority**: Let's Encrypt
- **Renewal**: Automated via systemd timer (every 12 hours)
- **Configuration**: Mozilla Modern profile

#### 2. Firewall Configuration
```bash
# Allowed ports
80/tcp   - HTTP (ACME challenges)
443/tcp  - HTTPS (Application traffic)
8080/tcp - Direct application access

# Rich rules
- Subnet access: 10.1.8.0/24
- SSH access: From subnet only
- Logging: Denied packets (5/minute limit)
```

#### 3. SELinux Enforcement
```bash
# Mode: Enforcing
# Policy: Targeted
# Container contexts: container_file_t

# Verify
getenforce  # Should return "Enforcing"
```

#### 4. Container Security
- ✅ Rootless execution (no root privileges)
- ✅ No new privileges flag
- ✅ Private /tmp filesystem
- ✅ Read-only root filesystem (where possible)
- ✅ Capability dropping
- ✅ Resource limits (CPU, Memory)

### Security Best Practices

1. **Regular Updates**
   ```bash
   # Update base images
   podman pull registry.access.redhat.com/ubi9/ubi-minimal:latest
   
   # Rebuild containers
   cd container && ./build-push.sh
   ```

2. **Certificate Management**
   ```bash
   # Test renewal
   certbot renew --dry-run
   
   # Force renewal
   certbot renew --force-renewal
   ```

3. **Audit Logs**
   ```bash
   # Firewall logs
   journalctl -u firewalld
   
   # SELinux denials
   ausearch -m avc -ts recent
   
   # Container logs
   podman logs aqua-topia-app
   ```

---

## 📊 Monitoring & Health Checks

### Health Endpoints

```bash
# Application health
curl http://localhost:8080/health

# Expected response
{
  "status": "healthy",
  "app": "Aqua Topia",
  "team": 8
}
```

### Service Status

```bash
# Check systemd service
systemctl --user status aqua-topia-app

# Check container status
podman ps --filter "name=aqua-topia-app"

# Check logs
journalctl --user -u aqua-topia-app -f
```

### Monitoring Checklist

- [ ] Container running: `podman ps`
- [ ] Service active: `systemctl --user is-active aqua-topia-app`
- [ ] Port listening: `ss -tlnp | grep 8080`
- [ ] Health check passing: `curl localhost:8080/health`
- [ ] Firewall rules active: `firewall-cmd --list-all`
- [ ] SELinux enforcing: `getenforce`
- [ ] Certificate valid: `certbot certificates`

---

## 🔧 Troubleshooting

### Common Issues

#### Container Won't Start

```bash
# Check logs
podman logs aqua-topia-app

# Check for port conflicts
ss -tlnp | grep 8080

# Verify image exists
podman images | grep aqua-topia

# Manual start for debugging
podman run -it --rm -p 8080:8080 quay.io/htf25-team8/aqua-topia:latest
```

#### Certificate Issues

```bash
# Check certificate status
certbot certificates

# Check firewall allows HTTP
firewall-cmd --list-ports | grep 80

# Test renewal
certbot renew --dry-run

# Force new certificate
certbot delete --cert-name www8.htf25.qubr.be
certbot certonly --standalone -d www8.htf25.qubr.be
```

#### Firewall Blocking Traffic

```bash
# Check active rules
firewall-cmd --list-all

# Reload firewall
firewall-cmd --reload

# Test connectivity
curl -v http://localhost:8080

# Check SELinux denials
ausearch -m avc -ts recent | grep denied
```

#### Service Won't Start

```bash
# Check service status
systemctl --user status aqua-topia-app

# Reload systemd
systemctl --user daemon-reload

# Check for lingering
loginctl show-user hacker | grep Linger

# Enable lingering if needed
sudo loginctl enable-linger hacker
```

### Debug Mode

Enable verbose logging:

```bash
# Set environment for debugging
export PODMAN_LOG_LEVEL=debug

# Run with debugging
podman run --log-level debug aqua-topia-app
```

### Getting Help

1. Check logs: `journalctl --user -u aqua-topia-app -n 100`
2. Verify network: `curl -v localhost:8080/health`
3. Check SELinux: `sealert -a /var/log/audit/audit.log`
4. Review firewall: `firewall-cmd --list-all-zones`

---

## 👥 Team

### HTF 2025 - Team 8

**Project**: Aqua Topia  
**Challenge**: Infrastructure Automation & Security  
**Subnet**: 10.1.8.0/24  

#### Team Members
- Infrastructure Architect
- Security Engineer
- DevOps Specialist
- Container Engineer

#### Contact
- **Email**: team8@htf25.qubr.be
- **Domain**: www8.htf25.qubr.be
- **Bastion**: bastion8.htf25.qubr.be

---

## 📝 License

This project was created for HTF 2025 Challenge - Team 8 submission.

---

## 🙏 Acknowledgments

- **HTF 2025 Organization** - For hosting the challenge
- **Red Hat** - For UBI container images and SELinux
- **Let's Encrypt** - For free TLS certificates
- **Ansible Community** - For automation framework
- **Podman Project** - For rootless container technology

---

<div align="center">

**Built with ❤️ by HTF 2025 Team 8**

*Demonstrating modern DevOps practices, security hardening, and infrastructure automation*

[![Made with Ansible](https://img.shields.io/badge/Made%20with-Ansible-EE0000?style=flat-square&logo=ansible&logoColor=white)](https://www.ansible.com/)
[![Powered by Podman](https://img.shields.io/badge/Powered%20by-Podman-892CA0?style=flat-square&logo=podman&logoColor=white)](https://podman.io/)
[![Secured by SELinux](https://img.shields.io/badge/Secured%20by-SELinux-0066CC?style=flat-square&logo=redhat&logoColor=white)](https://www.redhat.com/)

</div>
