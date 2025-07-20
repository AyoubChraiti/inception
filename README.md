# 🚀 Inception Project

The **Inception** project is a system administration exercise designed to deepen understanding of containerization and orchestration using Docker.  
The primary goal was to create a small, secure, and efficient infrastructure composed of multiple services running in Docker containers within a virtual machine.  

The project leverages **Docker Compose** to orchestrate a web stack consisting of **NGINX**, **WordPress**, and **MariaDB**, with additional bonus services to enhance functionality. The infrastructure was built from scratch, emphasizing custom Docker images, secure configurations, and best practices for container management.


## ⚙️ Project Setup and Environment

- Configured a **virtual machine** to host the entire infrastructure, ensuring isolation and consistency.
- Created a `srcs` directory to house all configuration files, including `Dockerfiles`, `docker-compose.yml`, and a `.env` file for environment variables.
- Developed a `Makefile` at the root of the project to automate the building and running of Docker images via `docker-compose.yml`.

## 🐳 Docker Image Creation

- Wrote custom `Dockerfiles` for each service (**NGINX**, **WordPress**, **MariaDB**, and bonus services) using the penultimate stable version of **Debian** as the base image.
- Built Docker images from scratch, avoiding pre-built images from DockerHub (except Debian) to ensure full control over configurations.
- Ensured each service ran in its own dedicated container, named identically to its service for clarity.

## 🔧 Core Service Implementation

- **NGINX Container**:  
  Configured as the sole entry point, accessible only via **port 443** with **TLSv1.2/1.3**. A custom domain (`login.42.fr`) points to the local IP (e.g., `wil.42.fr`).

- **WordPress Container**:  
  Installed with **PHP-FPM** (without NGINX) to serve dynamic content. Created two database users, including an **admin with a non-standard username** for security.

- **MariaDB Container**:  
  Configured to store WordPress data securely, running independently without NGINX.


## 📦 Volume and Network Configuration

- Created two Docker volumes:
  - One for the **WordPress database**
  - One for **WordPress files**

  These are stored at `/home/login/data` on the host.

- Established a **Docker network** explicitly defined in `docker-compose.yml`, avoiding deprecated options like `--link`.

## 🔐 Security and Best Practices

- Enabled **automatic container restart** in case of failure.
- Avoided "hacky" practices like `tail -f`, `sleep infinity`, or infinite loops.
- Managed sensitive data (like passwords) using `.env` and **Docker secrets**.
- Avoided using `latest` tags to ensure **version consistency**.

## 🗂️ Directory Structure

Organized with a clean structure under `srcs`, ensuring easy maintenance.
```
├── docker-compose.yml
├── .env
├── nginx/Dockerfile
├── wordpress/Dockerfile
├── mariadb/Dockerfile
├── redis/Dockerfile
├── ftp/Dockerfile
├── static-site/Dockerfile
├── adminer/Dockerfile
└── [custom-service]/Dockerfile
./Makefile
```
---

## 📚 Core Concepts Explained

### 🐋 Docker

Docker packages applications and dependencies into **lightweight containers**.  
Each service (NGINX, WordPress, MariaDB, etc.) was containerized using **custom Dockerfiles** for reproducibility and control.

### 🆚 Containerization vs. Virtual Machines

- Containers are **lightweight** and share the host OS kernel.
- Virtual machines are heavier, emulating full operating systems.
- Services like **NGINX and MariaDB** were properly daemonized (as PID 1), avoiding VM-like hacks.

### 🧩 Docker Compose

Defined services in `docker-compose.yml` to:
- Launch containers
- Setup networks and volumes
- Handle service dependencies

This enabled **modular and scalable orchestration**.

### 💾 Docker Volumes

Used for **persistent storage**:
- One for MariaDB data
- One for WordPress site files

Mounted at `/home/login/data` on the host to ensure durability.

### 🌐 Docker Networking

Defined a **custom Docker network** for internal communication between services.

- NGINX exposed only on **port 443**
- Other containers remained **isolated**
- Avoided deprecated methods like `--link`

### 🔒 Security Practices

- Enabled **TLSv1.2/1.3** for encrypted traffic.
- Stored secrets in `.env` and **excluded them** from version control.
- Used **non-standard admin usernames** to avoid brute-force attacks.

### ⚙️ Service-Specific Configurations

- **NGINX**:  
  Reverse proxy handling HTTPS traffic.

- **WordPress + PHP-FPM**:  
  Handles dynamic content, decoupled from the web server.

- **MariaDB**:  
  Stores WordPress data securely with two distinct users.

- **Redis**:  
  Speeds up WordPress with caching.

- **FTP Server**:  
  Enables secure file access for managing WordPress site files.

- **Adminer**:  
  Lightweight MariaDB management GUI.

- **Static Website**:  
  A simple HTML/CSS site deployed as a bonus service.

## 🤖 Automation with Makefile

The `Makefile` automated:

- Docker image builds
- Container orchestration via `docker-compose`

This simplified setup and teardown, reducing manual errors and speeding up deployment.

🎉 **Inception** provided valuable experience in secure, modular infrastructure design using Docker.  
It emphasized **clean architecture**, **automation**, and **modern DevOps practices** — foundational skills for real-world system deployment.
