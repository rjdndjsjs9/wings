FROM ubuntu:22.04


ENV DEBIAN_FRONTEND=noninteractive
ENV LOG_ROTATION=false  # Menonaktifkan fitur log rotation Wings


RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    systemd \
    util-linux \
    docker.io \
    && rm -rf /var/lib/apt/lists/*


RUN groupadd -g 999 pterodactyl && \
    useradd -m -d /home/pterodactyl -u 999 -g 999 -s /bin/bash pterodactyl && \
    usermod -aG docker pterodactyl


WORKDIR /home/pterodactyl


COPY config.yml /etc/pterodactyl/config.yml

RUN chown -R pterodactyl:pterodactyl /home/pterodactyl /etc/pterodactyl

EXPOSE 8080

CMD service docker start && sudo -u pterodactyl /usr/local/bin/wings
