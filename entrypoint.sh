#!/bin/bash
echo "Ensuring permissions..."
mkdir -p /var/log/pterodactyl
chown -R wings:wings /var/log/pterodactyl

echo "Starting Wings with SSL..."
exec /usr/local/bin/wings --config /etc/pterodactyl/config.yml
