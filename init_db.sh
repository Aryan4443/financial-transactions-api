#!/bin/bash

# Initialize database and run migrations
echo "Running database migrations..."
alembic upgrade head

echo "Database initialized successfully!"

