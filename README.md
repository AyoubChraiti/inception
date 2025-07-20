### Inception Project
The Inception project is a system administration exercise designed to deepen understanding of containerization and orchestration using Docker. The primary goal was to create a small, secure, and efficient infrastructure composed of multiple services running in Docker containers within a virtual machine. The project leverages Docker Compose to orchestrate a web stack consisting of NGINX, WordPress, and MariaDB, with additional bonus services to enhance functionality. The infrastructure was built from scratch, emphasizing custom Docker images, secure configurations, and best practices for container management.
Work Accomplished
The Inception project involved the following tasks and implementations, adhering to the mandatory and bonus requirements outlined in the project guidelines:

## Project Setup and Environment:

Configured a virtual machine to host the entire infrastructure, ensuring isolation and consistency.
Created a srcs directory to house all configuration files, including Dockerfiles, docker-compose.yml, and a .env file for environment variables.
Developed a Makefile at the root of the project to automate the building and running of Docker images via docker-compose.yml.

## Docker Image Creation:

Wrote custom Dockerfiles for each service (NGINX, WordPress, MariaDB, and bonus services) using the penultimate stable version of Debian as the base image for performance and stability.
Built Docker images from scratch, avoiding pre-built images from DockerHub (except for the base Debian image) to ensure full control over configurations.
Ensured each service ran in its own dedicated container, named identically to its service for clarity.


## Core Service Implementation:

 - NGINX Container: Configured NGINX as the sole entry point to the infrastructure, accessible only via port 443 with TLSv1.2 or TLSv1.3 for secure communication. Set up a custom domain (login.42.fr) pointing to the local IP address, replacing login with the user’s specific login (e.g., wil.42.fr).
 - WordPress Container: Installed and configured WordPress with PHP-FPM (without NGINX) to serve a dynamic website. Created two database users, including an administrator with a non-standard username (avoiding "admin" or similar terms) for enhanced security.
 - MariaDB Container: Set up MariaDB as the database service, configured to store WordPress data securely without NGINX.


## Volume and Network Configuration:

Created two Docker volumes: one for the WordPress database and another for WordPress website files, stored in /home/login/data on the host machine (with login replaced by the user’s login).
Established a Docker network to enable communication between containers, explicitly defined in docker-compose.yml, avoiding deprecated options like network: host or --link.


## Security and Best Practices:

Configured containers to restart automatically in case of crashes, ensuring high availability.
Avoided hacky practices such as tail -f, sleep infinity, or infinite loops in entrypoints, adhering to Docker best practices for handling PID 1.
Used environment variables in a .env file and Docker secrets to securely manage sensitive information like passwords, which were excluded from Dockerfiles.
Ensured the latest tag was not used for Docker images to maintain version consistency.

## Directory Structure:
  -> Organized the project with a clear directory structure, ensuring all configuration files were placed in the srcs folder, as required.

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

## Core Concepts Explained
The Inception project revolves around key system administration and containerization concepts, which were critical to its implementation. Below is an explanation of the core concepts utilized:

### Docker:

Docker is a platform for containerization, allowing applications and their dependencies to be packaged into lightweight, portable containers. In this project, Docker was used to create isolated environments for NGINX, WordPress, MariaDB, and bonus services, ensuring consistent behavior across different systems.
Custom Dockerfiles were written to define the setup process for each service, specifying the base image (Debian), installing necessary packages, and configuring the service. This approach ensured reproducibility and control over the environment.


### Containerization vs. Virtual Machines:

Unlike virtual machines, which emulate entire operating systems and are resource-heavy, Docker containers share the host OS kernel, making them lightweight and efficient. The project emphasized this distinction by discouraging VM-like hacks (e.g., tail -f) and requiring proper daemon management for services like NGINX and MariaDB.
Containers were configured to run a single process (e.g., NGINX or PHP-FPM) as PID 1, following Docker best practices to handle signals correctly and avoid zombie processes.


### Docker Compose:

Docker Compose is a tool for defining and running multi-container Docker applications using a YAML file (docker-compose.yml). In this project, it orchestrated the NGINX, WordPress, MariaDB, and bonus service containers, defining their relationships, networks, and volumes.
The docker-compose.yml file specified the Docker network for inter-container communication and linked volumes to persist data, ensuring a cohesive infrastructure.


### Docker Volumes:

Volumes provide persistent storage for Docker containers, allowing data to survive container restarts or deletions. The project used two volumes: one for the WordPress database (to store MariaDB data) and one for WordPress website files, both accessible on the host at /home/login/data.
This setup ensured data durability and simplified backups or migrations.


### Docker Networking:

Docker networks enable secure communication between containers. The project required a custom Docker network defined in docker-compose.yml, allowing services like WordPress and MariaDB to communicate while keeping NGINX as the sole external entry point via port 443.
Deprecated networking options like --link were avoided, ensuring modern and scalable network configurations.


### Security Practices:

The project enforced secure configurations, such as using TLSv1.2 or TLSv1.3 for NGINX to encrypt traffic, protecting data in transit.
Sensitive information (e.g., database passwords) was stored in a .env file and managed via Docker secrets, preventing exposure in Dockerfiles or version control.
The requirement for a non-standard administrator username in WordPress prevented common attack vectors targeting default credentials.


### Service-Specific Configurations:

NGINX: A web server configured as a reverse proxy, handling HTTPS traffic on port 443 with TLS protocols, ensuring secure access to the WordPress site.
WordPress with PHP-FPM: WordPress was set up with PHP-FPM (FastCGI Process Manager) to handle dynamic content efficiently, separate from the NGINX web server, following a modular architecture.
MariaDB: A relational database management system used to store WordPress data, configured for secure access with two users (one administrator, one regular).
Redis: A caching layer to improve WordPress performance by storing frequently accessed data in memory.
FTP Server: Provided secure file access to the WordPress volume, useful for managing site files remotely.
Adminer: A lightweight database management tool, offering a user-friendly interface for MariaDB administration.
Static Website: A non-PHP site (e.g., in HTML/CSS) to demonstrate additional containerized service deployment.


### Automation with Makefile:

The Makefile automated the build and deployment process, invoking docker-compose.yml to create and start containers. This streamlined development and ensured consistency during setup.
