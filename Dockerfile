# Menggunakan image dasar Ubuntu
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LOG_ROTATION=false  # Menonaktifkan fitur log rotation Wings

# Update package list dan install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    systemd \
    util-linux \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Tambahkan user pterodactyl dan tambahkan ke grup docker
RUN groupadd -g 999 pterodactyl && \
    useradd -m -d /home/pterodactyl -u 999 -g 999 -s /bin/bash pterodactyl && \
    usermod -aG docker pterodactyl

# Set working directory
WORKDIR /home/pterodactyl

# Copy file konfigurasi Wings
COPY config.yml /etc/pterodactyl/config.yml

# Set permission agar user pterodactyl bisa mengakses Docker
RUN chown -R pterodactyl:pterodactyl /home/pterodactyl /etc/pterodactyl

# Expose port yang diperlukan
EXPOSE 8080

# Start Docker daemon sebelum menjalankan Wings
CMD service docker start && sudo -u pterodactyl /usr/local/bin/wings
