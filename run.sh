#!/bin/bash

# Run the Financial Transaction API

echo "Starting Financial Transaction API..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "Warning: .env file not found. Please create one from .env.example"
    echo "Using default environment variables..."
fi

# Run the application
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

