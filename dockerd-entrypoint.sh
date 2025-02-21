#!/bin/sh

# Start Docker daemon
dockerd --host=unix:///var/run/docker.sock --host=tcp://127.0.0.1:2375 &

# Tunggu Docker ready
sleep 5

# Jalankan Wings
exec /home/pterodactyl/wings --config /etc/pterodactyl/config.yml
