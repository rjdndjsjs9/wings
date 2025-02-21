FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LOG_ROTATION=false  # Menonaktifkan fitur log rotation Wings

# Install dependencies
RUN apt update && apt install -y curl tar unzip

# Buat direktori Wings
RUN mkdir -p /etc/pterodactyl /var/log/pterodactyl /var/lib/pterodactyl/archives

# Download & install Wings
RUN curl -Lo /usr/local/bin/wings https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64
RUN chmod +x /usr/local/bin/wings

# Copy config
COPY config.yml /etc/pterodactyl/config.yml

# Set permission agar tidak ada error "permission denied"
RUN chmod -R 777 /var/log/pterodactyl /var/lib/pterodactyl /etc/pterodactyl

# Expose ports
EXPOSE 8080

# Jalankan Wings
CMD ["/usr/local/bin/wings", "--config", "/etc/pterodactyl/config.yml"]
