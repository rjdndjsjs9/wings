# Gunakan image dasar
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
    && rm -rf /var/lib/apt/lists/*

# Install Docker jika belum ada
RUN curl -fsSL https://get.docker.com | sh

# Buat user pterodactyl
RUN useradd -m -d /home/pterodactyl -s /bin/bash pterodactyl

# Set workdir
WORKDIR /home/pterodactyl

# Download dan install Wings
RUN curl -L -o wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64" \
    && chmod +x wings

# Copy config file
COPY config.yml /etc/pterodactyl/config.yml

# Expose ports
EXPOSE 8080 2022

# Start Wings
CMD ["/home/pterodactyl/wings"]
