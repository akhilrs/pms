#!/bin/bash

# Output basic diagnostic information
echo "Running in directory: $(pwd)"
echo "-----------------------"

echo "SHELL: $SHELL"
echo "-----------------------"

echo "PATH:"
echo $PATH
echo "-----------------------"

echo "Checking for docker:"
which docker || echo "docker not found"
echo "-----------------------"

echo "Checking for podman:"
which podman || echo "podman not found"
echo "-----------------------"

echo "Listing supabase directory:"
ls -la supabase/
echo "-----------------------"

echo "Checking docker-compose.yml:"
cat supabase/docker-compose.yml | head -5
echo "-----------------------"

echo "Diagnostic complete" 