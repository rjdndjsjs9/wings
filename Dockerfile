# Gunakan image Ubuntu terbaru
FROM ubuntu:latest

# Install dependencies
RUN apt update && apt install -y curl tar jq sudo certbot

# Set timezone secara manual ke UTC
ENV TZ=UTC
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime && \
    echo "UTC" > /etc/timezone

# Tambahkan user "wings"
RUN useradd -m wings

# Unduh Wings dari Pterodactyl
RUN curl -Lo /usr/local/bin/wings https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64
RUN chmod +x /usr/local/bin/wings

# Buat direktori yang diperlukan
RUN mkdir -p /etc/pterodactyl /var/lib/pterodactyl/volumes /etc/letsencrypt/live/nodekuwings.up.railway.app /var/log/pterodactyl
RUN chown -R wings:wings /var/log/pterodactyl

# Copy konfigurasi Wings dan script entrypoint
COPY config.yml /etc/pterodactyl/config.yml
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set user sebagai "wings"
USER wings

# Set direktori kerja
WORKDIR /etc/pterodactyl

# Jalankan Wings dengan script entrypoint
ENTRYPOINT ["/entrypoint.sh"]
