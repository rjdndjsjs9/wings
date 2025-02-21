# Gunakan Docker-in-Docker
FROM docker:dind

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LOG_ROTATION=false

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    sudo \
    tzdata

# Buat user pterodactyl
RUN adduser -D -h /home/pterodactyl -s /bin/bash pterodactyl

# Set workdir
WORKDIR /home/pterodactyl

# Download dan install Wings
RUN curl -L -o wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64" \
    && chmod +x wings

# Copy config file
COPY config.yml /etc/pterodactyl/config.yml

# Expose ports
EXPOSE 8080 2022

# Start Docker daemon & Wings
CMD ["sh", "-c", "dockerd-entrypoint.sh & sleep 5 && ./wings"]
