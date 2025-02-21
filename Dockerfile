# Gunakan image Debian terbaru
FROM debian:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LOG_ROTATION=false

# Update package list dan install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    gnupg \
    software-properties-common \
    ca-certificates \
    tzdata \
    iproute2 \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Buat user pterodactyl
RUN useradd -m -d /home/pterodactyl -s /bin/bash pterodactyl

# Set workdir
WORKDIR /home/pterodactyl

# Download dan install Wings
RUN curl -L -o wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64" \
    && chmod +x wings \
    && mv wings /usr/local/bin/

# Copy config file
COPY config.yml /etc/pterodactyl/config.yml
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose ports
EXPOSE 8080 2022

# Start Wings
ENTRYPOINT ["/entrypoint.sh"]
