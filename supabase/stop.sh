#!/bin/bash

# Change to the directory containing this script
cd "$(dirname "$0")"

# Determine which container orchestration tool to use
if command -v podman compose &> /dev/null; then
    COMPOSE_CMD="podman compose"
elif command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
elif command -v podman-compose &> /dev/null; then
    COMPOSE_CMD="podman-compose"
else
    echo "Error: Neither podman compose, docker-compose, nor podman-compose found."
    echo "Please install either Docker with docker-compose or Podman with the compose plugin."
    exit 1
fi

# Stop Supabase services
echo "Stopping Supabase with $COMPOSE_CMD..."
$COMPOSE_CMD down

echo "Supabase services have been stopped." 