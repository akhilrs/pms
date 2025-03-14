#!/bin/bash

# Set up error handling
set -e
set -o pipefail

echo "=== Debugging Supabase Startup ==="
echo "Current directory: $(pwd)"

echo "=== Checking Docker Installation ==="
if command -v docker &> /dev/null; then
    echo "Docker is installed"
    docker --version
else
    echo "Docker is NOT installed"
fi

echo "=== Checking Docker Compose Installation ==="
if command -v docker-compose &> /dev/null; then
    echo "docker-compose is installed"
    docker-compose --version
elif command -v docker &> /dev/null && docker compose version &> /dev/null; then
    echo "Docker Compose plugin is installed"
    docker compose version
else
    echo "Docker Compose is NOT installed"
fi

echo "=== Checking Podman Installation ==="
if command -v podman &> /dev/null; then
    echo "Podman is installed"
    podman --version
else
    echo "Podman is NOT installed"
fi

echo "=== Checking Podman Compose Installation ==="
if command -v podman-compose &> /dev/null; then
    echo "podman-compose is installed"
    podman-compose --version
elif command -v podman &> /dev/null && podman compose --help &> /dev/null; then
    echo "Podman Compose plugin is installed"
    podman compose --version
else
    echo "Podman Compose is NOT installed"
fi

echo "=== Checking Supabase directory ==="
if [ -d "./supabase" ]; then
    echo "Supabase directory exists"
    ls -la supabase
else
    echo "Supabase directory does NOT exist in current location"
fi

echo "=== Checking Supabase docker-compose.yml ==="
if [ -f "./supabase/docker-compose.yml" ]; then
    echo "docker-compose.yml exists"
    cat ./supabase/docker-compose.yml | head -10
    echo "..."
else
    echo "docker-compose.yml does NOT exist"
fi

echo "=== Attempting to start Supabase services ==="
cd supabase

echo "Trying with docker compose..."
docker compose up -d 2>&1 || echo "Failed to start with docker compose"

echo "Trying with podman compose..."
podman compose up -d 2>&1 || echo "Failed to start with podman compose"

echo "=== Debugging complete ===" 