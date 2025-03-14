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

# Start Supabase services
echo "Starting Supabase with $COMPOSE_CMD..."
$COMPOSE_CMD up -d

# Wait for services to be ready
echo "Waiting for services to start up..."
sleep 10

echo "Supabase is now running!"
echo ""
echo "Services are available at:"
echo "PostgreSQL: localhost:5432"
echo "REST API: http://localhost:3001"
echo "Auth API: http://localhost:9999"
echo "Realtime API: http://localhost:4000"
echo "Storage API: http://localhost:5000"
echo ""
echo "To view logs: $COMPOSE_CMD logs -f"
echo "To stop: $COMPOSE_CMD down" 