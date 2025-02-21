#!/bin/bash

echo "Ensuring permissions..."
mkdir -p /var/log/pterodactyl
chown -R pterodactyl:pterodactyl /var/log/pterodactyl

echo "Starting Docker daemon..."
service docker start

echo "Starting Wings..."
exec wings --config /etc/pterodactyl/config.yml
