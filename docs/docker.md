# Docker Reference

Quick reference for Docker. Use `/` to search in vim.

## Table of Contents

- [Installation & Setup](#installation--setup)
- [Images](#images)
  - [build](#build)
  - [pull](#pull)
  - [push](#push)
  - [ls / list](#ls--list)
  - [inspect](#inspect)
  - [rm](#rm)
  - [tag](#tag)
- [Containers](#containers)
  - [run](#run)
  - [exec](#exec)
  - [start / stop](#start--stop)
  - [ps](#ps)
  - [logs](#logs)
  - [rm](#rm-1)
  - [inspect](#inspect-1)
  - [cp](#cp)
  - [port](#port)
- [Docker Compose](#docker-compose)
  - [up](#up)
  - [down](#down)
  - [ps](#ps-1)
  - [logs](#logs-1)
  - [exec](#exec-1)
- [Volumes](#volumes)
  - [volume create](#volume-create)
  - [volume ls](#volume-ls)
  - [volume inspect](#volume-inspect)
  - [volume rm](#volume-rm)
- [Networks](#networks)
  - [network create](#network-create)
  - [network ls](#network-ls)
  - [network connect](#network-connect)
  - [network disconnect](#network-disconnect)
- [Dockerfile](#dockerfile)
  - [Basic Structure](#basic-structure)
  - [Common Instructions](#common-instructions)
  - [Examples](#examples)
- [Docker Compose File](#docker-compose-file)
  - [Basic Structure](#basic-structure-1)
  - [Services](#services)
  - [Volumes](#volumes-1)
  - [Networks](#networks-1)
  - [Environment Variables](#environment-variables)
  - [Examples](#examples-1)
- [Best Practices](#best-practices)

## Installation & Setup

Install Docker and verify setup.

```bash
# macOS (using Homebrew)
brew install docker docker-compose

# Linux (Ubuntu/Debian)
sudo apt-get install docker.io docker-compose

# Start Docker daemon
sudo systemctl start docker
sudo systemctl enable docker  # Auto-start

# Verify installation
docker --version
docker compose --version
docker run hello-world
```

## Images

### build

Build image from Dockerfile.

```bash
docker build -t myimage:latest .
docker build -t myimage:1.0 --target production .
docker build -f Dockerfile.dev -t myimage:dev .
docker build --build-arg NODE_ENV=production -t myimage .
docker build --no-cache -t myimage .
```

### pull

Download image from registry.

```bash
docker pull ubuntu:latest
docker pull ubuntu:20.04
docker pull gcr.io/project/image:tag
docker pull myregistry.azurecr.io/image:tag
```

### push

Upload image to registry.

```bash
docker push myimage:latest
docker push gcr.io/project/image:tag
docker push myregistry.azurecr.io/image:tag

# Tag before pushing
docker tag myimage myregistry/myimage:latest
docker push myregistry/myimage:latest
```

### ls / list

List images.

```bash
docker images                              # List all images
docker image ls                            # Same as docker images
docker images --filter "dangling=true"    # Unused images
docker images -q                           # Only image IDs
```

### inspect

Show image details.

```bash
docker inspect myimage
docker inspect myimage:tag
docker inspect -f '{{.Config.Env}}' myimage  # Extract specific field
```

### rm

Delete image.

```bash
docker rmi myimage
docker rmi myimage:tag
docker rmi -f myimage                      # Force delete
docker image rm myimage
```

### tag

Tag image.

```bash
docker tag myimage myregistry/myimage:latest
docker tag myimage:v1.0 myimage:stable
docker tag myimage:latest myimage:1.0
```

## Containers

### run

Create and run container.

```bash
# Basic
docker run image-name
docker run image-name /bin/bash

# Interactive
docker run -it image-name /bin/bash
docker run --interactive --tty image-name bash

# Detached
docker run -d image-name
docker run --detach image-name

# Named container
docker run --name my-container image-name
docker run --rm image-name                 # Auto-remove on exit

# Port mapping
docker run -p 8080:3000 image-name         # Host:Container
docker run -p 8080:3000/tcp image-name
docker run -P image-name                   # Map all exposed ports

# Environment variables
docker run -e NODE_ENV=production image-name
docker run --env-file .env image-name

# Volume mounting
docker run -v /host/path:/container/path image-name
docker run -v named-volume:/container/path image-name

# Volume (read-only)
docker run -v /host/path:/container/path:ro image-name

# Network
docker run --network my-network image-name

# Resource limits
docker run --memory 512m image-name
docker run --cpus 1 image-name
docker run --memory 512m --cpus 0.5 image-name

# Restart policy
docker run --restart always image-name
docker run --restart unless-stopped image-name
docker run --restart on-failure:3 image-name

# Logging
docker run --log-driver json-file image-name
docker run -e LOG_LEVEL=debug image-name
```

### exec

Execute command in running container.

```bash
docker exec container-name echo "Hello"
docker exec -it container-name /bin/bash      # Interactive shell
docker exec -u root container-name whoami     # As specific user
docker exec container-name npm test           # Run command
docker exec -e VAR=value container-name bash  # With environment
docker exec -w /app container-name npm start  # In specific directory
```

### start / stop

Start or stop container.

```bash
docker start container-name
docker start container-id
docker start -a container-name               # Attach and display output

docker stop container-name
docker stop -t 10 container-name             # Wait 10 seconds before kill

docker restart container-name
docker pause container-name
docker unpause container-name
docker kill container-name                   # Force kill
```

### ps

List containers.

```bash
docker ps                                    # Running containers
docker ps -a                                 # All containers
docker ps -q                                 # Only container IDs
docker ps --filter "status=exited"
docker ps --filter "name=web"
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
```

### logs

View container logs.

```bash
docker logs container-name
docker logs -f container-name                # Follow (tail)
docker logs --tail 100 container-name        # Last 100 lines
docker logs --timestamps container-name
docker logs --since 2024-01-01 container-name
docker logs --until "2 minutes ago" container-name
```

### rm

Delete container.

```bash
docker rm container-name
docker rm -f container-name                  # Force delete running container
docker rm -v container-name                  # Remove volumes too
docker container prune                       # Remove all stopped containers
```

### inspect

Show container details.

```bash
docker inspect container-name
docker inspect -f '{{.State.Status}}' container-name  # Extract field
docker inspect -f '{{.NetworkSettings.IPAddress}}' container-name
```

### cp

Copy files between host and container.

```bash
docker cp container-name:/path/file /host/path
docker cp /host/path/file container-name:/path
docker cp /host/path/. container-name:/path  # Recursive copy
```

### port

Show port mappings.

```bash
docker port container-name
docker port container-name 3000              # Specific port
```

## Docker Compose

### up

Start services.

```bash
docker-compose up                            # Start and attach
docker-compose up -d                         # Detached
docker-compose up --build                    # Build images first
docker-compose up --no-build                 # Skip building
docker-compose up --scale web=3              # Scale service
docker-compose up service-name               # Start specific service
```

### down

Stop and remove services.

```bash
docker-compose down
docker-compose down --volumes                # Also remove volumes
docker-compose down --rmi all                # Remove all images
docker-compose down --rmi local              # Remove local images
```

### ps

List services.

```bash
docker-compose ps
docker-compose ps -a                         # Include stopped
```

### logs

View logs.

```bash
docker-compose logs
docker-compose logs -f                       # Follow
docker-compose logs service-name
docker-compose logs --tail 100 service-name
```

### exec

Execute command in service.

```bash
docker-compose exec service-name /bin/bash
docker-compose exec -it service-name npm test
docker-compose exec -u root service-name whoami
```

## Volumes

### volume create

Create volume.

```bash
docker volume create my-volume
docker volume create --driver local my-volume
```

### volume ls

List volumes.

```bash
docker volume ls
docker volume ls -f "dangling=true"          # Unused volumes
```

### volume inspect

Show volume details.

```bash
docker volume inspect my-volume
```

### volume rm

Delete volume.

```bash
docker volume rm my-volume
docker volume prune                          # Remove unused
docker volume prune -f                       # Force remove
```

## Networks

### network create

Create network.

```bash
docker network create my-network
docker network create --driver bridge my-network
docker network create --driver overlay my-network  # Swarm only
docker network create --subnet 172.20.0.0/16 my-network
```

### network ls

List networks.

```bash
docker network ls
docker network ls --filter "driver=bridge"
```

### network connect

Connect container to network.

```bash
docker network connect my-network container-name
docker network connect --ip 172.20.0.5 my-network container-name
```

### network disconnect

Disconnect container from network.

```bash
docker network disconnect my-network container-name
docker network disconnect -f my-network container-name  # Force
```

## Dockerfile

### Basic Structure

```dockerfile
FROM ubuntu:20.04

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y node

EXPOSE 3000

ENV NODE_ENV=production

ENTRYPOINT ["node"]
CMD ["app.js"]
```

### Common Instructions

```dockerfile
# Base image
FROM ubuntu:20.04
FROM node:18-alpine

# Working directory
WORKDIR /app

# Copy files
COPY src/ /app/src/
COPY package*.json ./

# Run commands (build time)
RUN npm install
RUN apt-get update && apt-get install -y curl

# Expose port (documentation)
EXPOSE 3000
EXPOSE 3000 8080

# Environment variable
ENV NODE_ENV=production
ENV APP_KEY=secret

# Volume (mount point)
VOLUME ["/data"]

# Default command (can be overridden)
CMD ["npm", "start"]
CMD npm start

# Entry point (always runs)
ENTRYPOINT ["node"]
ENTRYPOINT ["node", "app.js"]

# Metadata
LABEL author="John Doe"
LABEL version="1.0"

# User
RUN useradd -m appuser
USER appuser

# Health check
HEALTHCHECK --interval=30s CMD node health.js

# Execute command
RUN ["npm", "install"]
RUN npm install
```

### Examples

Node.js application:

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
```

Multi-stage build:

```dockerfile
# Build stage
FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["node", "dist/index.js"]
```

## Docker Compose File

### Basic Structure

```yaml
version: "3.8"

services:
  web:
    image: node:18
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    volumes:
      - ./src:/app/src
    depends_on:
      - db

  db:
    image: postgres:14
    environment:
      - POSTGRES_PASSWORD=secret

volumes:
  db-data:

networks:
  default:
    name: my-network
```

### Services

```yaml
services:
  web:
    # Image or build from Dockerfile
    image: node:18
    # build: .
    # build:
    #   context: .
    #   dockerfile: Dockerfile.dev
    #   args:
    #     NODE_ENV: development

    # Container name
    container_name: my-web

    # Ports (host:container)
    ports:
      - "3000:3000"
      - "8080:3000"

    # Expose ports (only within network)
    expose:
      - "3000"

    # Environment variables
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgres://db:5432/mydb
    # env_file: .env

    # Working directory
    working_dir: /app

    # Volumes (host:container or named)
    volumes:
      - ./src:/app/src
      - ./data:/app/data:ro
      - my-volume:/data

    # Networks
    networks:
      - my-network

    # Depends on
    depends_on:
      - db
    # depends_on:
    #   db:
    #     condition: service_healthy

    # Restart policy
    restart: unless-stopped
    # restart: always
    # restart: on-failure
    # restart: no

    # Resource limits
    # deploy:
    #   limits:
    #     cpus: '0.5'
    #     memory: 512M
    #   reservations:
    #     cpus: '0.25'
    #     memory: 256M

    # Command
    command: npm start
    # command: ["npm", "start"]

    # Logging
    logging:
      driver: json-file
      options:
        max-size: "10m"
        max-file: "3"
```

### Volumes

```yaml
volumes:
  db-data:
    driver: local
  my-volume:
    external: true
```

### Networks

```yaml
networks:
  my-network:
    driver: bridge
  external-net:
    external: true
```

### Environment Variables

```yaml
# Inline
environment:
  - NODE_ENV=production
  - DEBUG=true

# From file
env_file: .env

# Combined
environment:
  NODE_ENV: ${NODE_ENV:-production}
  API_URL: http://api:3000
```

### Examples

Full stack with database:

```yaml
version: "3.8"

services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgresql://user:password@db:5432/mydb
      - NODE_ENV=production
    volumes:
      - ./src:/app/src
    depends_on:
      - db
    networks:
      - app-network

  db:
    image: postgres:14-alpine
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=mydb
    volumes:
      - db-data:/var/lib/postgresql/data
    networks:
      - app-network

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    networks:
      - app-network

volumes:
  db-data:

networks:
  app-network:
    driver: bridge
```

## Best Practices

```dockerfile
# 1. Use specific base image versions (not latest)
FROM node:18.12.1-alpine

# 2. Multi-stage builds to reduce size
FROM node:18 AS builder
# ...build steps...
FROM node:18-alpine
COPY --from=builder /app/dist ./dist

# 3. Minimize layers
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 4. Use .dockerignore
# Add .dockerignore with node_modules, .git, etc.

# 5. Run as non-root user
RUN useradd -m appuser
USER appuser

# 6. Include health checks
HEALTHCHECK --interval=30s --timeout=3s \
  CMD node health.js || exit 1

# 7. Use environment variables for configuration
ENV NODE_ENV=production
ENV PORT=3000

# 8. Order Dockerfile for layer caching
# Put frequently changing steps at end
```

Useful docker commands for cleanup:

```bash
# Remove stopped containers
docker container prune -f

# Remove dangling images
docker image prune -f

# Remove unused volumes
docker volume prune -f

# Remove everything unused
docker system prune -a
docker system prune -a --volumes

# View disk usage
docker system df
```
