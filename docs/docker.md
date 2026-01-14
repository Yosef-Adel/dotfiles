*docker.txt*  Docker Reference

==============================================================================
CONTENTS                                                      *docker-contents*

1. Installation & Setup .................. |docker-install|
2. Images ................................ |docker-images|
3. Containers ............................ |docker-containers|
4. Docker Compose ........................ |docker-compose|
5. Volumes ............................... |docker-volumes|
6. Networks .............................. |docker-networks|
7. Dockerfile ............................ |docker-dockerfile|
8. Docker Compose File ................... |docker-compose-file|
9. Best Practices ........................ |docker-best-practices|

==============================================================================
1. INSTALLATION & SETUP                                       *docker-install*

Install Docker and verify setup~
>
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
<

==============================================================================
2. IMAGES                                                      *docker-images*

Build image from Dockerfile~                           *docker-build*
>
    docker build -t myimage:latest .
    docker build -t myimage:1.0 --target production .
    docker build -f Dockerfile.dev -t myimage:dev .
    docker build --build-arg NODE_ENV=production -t myimage .
    docker build --no-cache -t myimage .
<

Download image from registry~                          *docker-pull*
>
    docker pull ubuntu:latest
    docker pull ubuntu:20.04
    docker pull gcr.io/project/image:tag
    docker pull myregistry.azurecr.io/image:tag
<

Upload image to registry~                              *docker-push*
>
    docker push myimage:latest
    docker push gcr.io/project/image:tag

    # Tag before pushing
    docker tag myimage myregistry/myimage:latest
    docker push myregistry/myimage:latest
<

List images~                                           *docker-images-ls*
>
    docker images                              # List all images
    docker image ls                            # Same as docker images
    docker images --filter "dangling=true"    # Unused images
    docker images -q                           # Only image IDs
<

Show image details~                                    *docker-inspect-image*
>
    docker inspect myimage
    docker inspect myimage:tag
    docker inspect -f '{{.Config.Env}}' myimage  # Extract specific field
<

Delete image~                                          *docker-rmi*
>
    docker rmi myimage
    docker rmi myimage:tag
    docker rmi -f myimage                      # Force delete
    docker image rm myimage
<

Tag image~                                             *docker-tag*
>
    docker tag myimage myregistry/myimage:latest
    docker tag myimage:v1.0 myimage:stable
    docker tag myimage:latest myimage:1.0
<

==============================================================================
3. CONTAINERS                                              *docker-containers*

Create and run container~                             *docker-run*
>
    # Basic
    docker run image-name
    docker run image-name /bin/bash

    # Interactive
    docker run -it image-name /bin/bash

    # Detached
    docker run -d image-name

    # Named container
    docker run --name my-container image-name
    docker run --rm image-name                 # Auto-remove on exit
<

Port mapping~                                          *docker-run-port*
>
    docker run -p 8080:3000 image-name         # Host:Container
    docker run -p 8080:3000/tcp image-name
    docker run -P image-name                   # Map all exposed ports
<

Environment variables~                                 *docker-run-env*
>
    docker run -e NODE_ENV=production image-name
    docker run --env-file .env image-name
<

Volume mounting~                                       *docker-run-volume*
>
    docker run -v /host/path:/container/path image-name
    docker run -v named-volume:/container/path image-name
    docker run -v /host/path:/container/path:ro image-name  # Read-only
<

Network~                                               *docker-run-network*
>
    docker run --network my-network image-name
<

Resource limits~                                       *docker-run-resources*
>
    docker run --memory 512m image-name
    docker run --cpus 1 image-name
    docker run --memory 512m --cpus 0.5 image-name
<

Restart policy~                                        *docker-run-restart*
>
    docker run --restart always image-name
    docker run --restart unless-stopped image-name
    docker run --restart on-failure:3 image-name
<

Execute command in running container~                 *docker-exec*
>
    docker exec container-name echo "Hello"
    docker exec -it container-name /bin/bash      # Interactive shell
    docker exec -u root container-name whoami     # As specific user
    docker exec container-name npm test           # Run command
    docker exec -e VAR=value container-name bash  # With environment
    docker exec -w /app container-name npm start  # In specific directory
<

Start or stop container~                              *docker-start*
>
    docker start container-name
    docker start -a container-name               # Attach and display output

    docker stop container-name
    docker stop -t 10 container-name             # Wait 10 seconds before kill

    docker restart container-name
    docker pause container-name
    docker unpause container-name
    docker kill container-name                   # Force kill
<

List containers~                                       *docker-ps*
>
    docker ps                                    # Running containers
    docker ps -a                                 # All containers
    docker ps -q                                 # Only container IDs
    docker ps --filter "status=exited"
    docker ps --filter "name=web"
    docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
<

View container logs~                                   *docker-logs*
>
    docker logs container-name
    docker logs -f container-name                # Follow (tail)
    docker logs --tail 100 container-name        # Last 100 lines
    docker logs --timestamps container-name
    docker logs --since 2024-01-01 container-name
    docker logs --until "2 minutes ago" container-name
<

Delete container~                                      *docker-rm*
>
    docker rm container-name
    docker rm -f container-name                  # Force delete running container
    docker rm -v container-name                  # Remove volumes too
    docker container prune                       # Remove all stopped containers
<

Show container details~                                *docker-inspect*
>
    docker inspect container-name
    docker inspect -f '{{.State.Status}}' container-name
    docker inspect -f '{{.NetworkSettings.IPAddress}}' container-name
<

Copy files~                                            *docker-cp*
>
    docker cp container-name:/path/file /host/path
    docker cp /host/path/file container-name:/path
    docker cp /host/path/. container-name:/path  # Recursive copy
<

Show port mappings~                                    *docker-port*
>
    docker port container-name
    docker port container-name 3000              # Specific port
<

==============================================================================
4. DOCKER COMPOSE                                           *docker-compose*

Start services~                                        *docker-compose-up*
>
    docker-compose up                            # Start and attach
    docker-compose up -d                         # Detached
    docker-compose up --build                    # Build images first
    docker-compose up --no-build                 # Skip building
    docker-compose up --scale web=3              # Scale service
    docker-compose up service-name               # Start specific service
<

Stop and remove services~                             *docker-compose-down*
>
    docker-compose down
    docker-compose down --volumes                # Also remove volumes
    docker-compose down --rmi all                # Remove all images
    docker-compose down --rmi local              # Remove local images
<

List services~                                         *docker-compose-ps*
>
    docker-compose ps
    docker-compose ps -a                         # Include stopped
<

View logs~                                             *docker-compose-logs*
>
    docker-compose logs
    docker-compose logs -f                       # Follow
    docker-compose logs service-name
    docker-compose logs --tail 100 service-name
<

Execute command in service~                            *docker-compose-exec*
>
    docker-compose exec service-name /bin/bash
    docker-compose exec -it service-name npm test
    docker-compose exec -u root service-name whoami
<

==============================================================================
5. VOLUMES                                                  *docker-volumes*

Create volume~                                         *docker-volume-create*
>
    docker volume create my-volume
    docker volume create --driver local my-volume
<

List volumes~                                          *docker-volume-ls*
>
    docker volume ls
    docker volume ls -f "dangling=true"          # Unused volumes
<

Show volume details~                                   *docker-volume-inspect*
>
    docker volume inspect my-volume
<

Delete volume~                                         *docker-volume-rm*
>
    docker volume rm my-volume
    docker volume prune                          # Remove unused
    docker volume prune -f                       # Force remove
<

==============================================================================
6. NETWORKS                                                *docker-networks*

Create network~                                        *docker-network-create*
>
    docker network create my-network
    docker network create --driver bridge my-network
    docker network create --driver overlay my-network  # Swarm only
    docker network create --subnet 172.20.0.0/16 my-network
<

List networks~                                         *docker-network-ls*
>
    docker network ls
    docker network ls --filter "driver=bridge"
<

Connect container to network~                          *docker-network-connect*
>
    docker network connect my-network container-name
    docker network connect --ip 172.20.0.5 my-network container-name
<

Disconnect container from network~                     *docker-network-disconnect*
>
    docker network disconnect my-network container-name
    docker network disconnect -f my-network container-name  # Force
<

==============================================================================
7. DOCKERFILE                                              *docker-dockerfile*

Basic Structure~                                       *dockerfile-basic*
>
    FROM ubuntu:20.04

    WORKDIR /app

    COPY . .

    RUN apt-get update && apt-get install -y node

    EXPOSE 3000

    ENV NODE_ENV=production

    ENTRYPOINT ["node"]
    CMD ["app.js"]
<

Common Instructions~                                   *dockerfile-instructions*

Base image~
>
    FROM ubuntu:20.04
    FROM node:18-alpine
<

Working directory~
>
    WORKDIR /app
<

Copy files~
>
    COPY src/ /app/src/
    COPY package*.json ./
<

Run commands (build time)~
>
    RUN npm install
    RUN apt-get update && apt-get install -y curl
<

Expose port (documentation)~
>
    EXPOSE 3000
    EXPOSE 3000 8080
<

Environment variable~
>
    ENV NODE_ENV=production
    ENV APP_KEY=secret
<

Volume (mount point)~
>
    VOLUME ["/data"]
<

Default command~
>
    CMD ["npm", "start"]
    CMD npm start
<

Entry point~
>
    ENTRYPOINT ["node"]
    ENTRYPOINT ["node", "app.js"]
<

Note: CMD can be overridden, ENTRYPOINT always runs.

Metadata~
>
    LABEL author="John Doe"
    LABEL version="1.0"
<

User~
>
    RUN useradd -m appuser
    USER appuser
<

Health check~
>
    HEALTHCHECK --interval=30s CMD node health.js
<

Node.js Example~                                       *dockerfile-nodejs*
>
    FROM node:18-alpine

    WORKDIR /app

    COPY package*.json ./

    RUN npm ci

    COPY . .

    EXPOSE 3000

    CMD ["npm", "start"]
<

Multi-stage Build~                                     *dockerfile-multistage*
>
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
<

==============================================================================
8. DOCKER COMPOSE FILE                                  *docker-compose-file*

Basic Structure~                                       *compose-basic*
>
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
<

Services~                                              *compose-services*
>
    services:
      web:
        # Image or build
        image: node:18
        # build: .

        # Container name
        container_name: my-web

        # Ports (host:container)
        ports:
          - "3000:3000"
          - "8080:3000"

        # Environment variables
        environment:
          - NODE_ENV=production
          - DATABASE_URL=postgres://db:5432/mydb

        # Volumes
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

        # Restart policy
        restart: unless-stopped

        # Command
        command: npm start

        # Logging
        logging:
          driver: json-file
          options:
            max-size: "10m"
            max-file: "3"
<

Volumes~                                               *compose-volumes*
>
    volumes:
      db-data:
        driver: local
      my-volume:
        external: true
<

Networks~                                              *compose-networks*
>
    networks:
      my-network:
        driver: bridge
      external-net:
        external: true
<

Environment Variables~                                 *compose-env*
>
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
<

Full Stack Example~                                    *compose-example*
>
    version: "3.8"

    services:
      web:
        build: .
        ports:
          - "3000:3000"
        environment:
          - DATABASE_URL=postgresql://user:password@db:5432/mydb
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
<

==============================================================================
9. BEST PRACTICES                                   *docker-best-practices*

Dockerfile Best Practices~                            *docker-best-dockerfile*

1. Use specific base image versions~
>
    FROM node:18.12.1-alpine  # Not :latest
<

2. Multi-stage builds to reduce size~
>
    FROM node:18 AS builder
    # ...build steps...
    FROM node:18-alpine
    COPY --from=builder /app/dist ./dist
<

3. Minimize layers~
>
    RUN apt-get update && \
        apt-get install -y curl && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*
<

4. Use .dockerignore~
Add .dockerignore with node_modules, .git, etc.

5. Run as non-root user~
>
    RUN useradd -m appuser
    USER appuser
<

6. Include health checks~
>
    HEALTHCHECK --interval=30s --timeout=3s \
      CMD node health.js || exit 1
<

7. Use environment variables for configuration~
>
    ENV NODE_ENV=production
    ENV PORT=3000
<

8. Order Dockerfile for layer caching~
Put frequently changing steps at end.

Cleanup Commands~                                      *docker-cleanup*
>
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
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
