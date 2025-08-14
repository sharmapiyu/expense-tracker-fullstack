#!/bin/bash

# Production Deployment Script for Expense Tracker
set -e

echo "🚀 Starting production deployment..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "❌ .env file not found. Please create one based on env.example"
    exit 1
fi

# Load environment variables
source .env

# Validate required environment variables
if [ -z "$DB_PASSWORD" ]; then
    echo "❌ DB_PASSWORD is required in .env file"
    exit 1
fi

if [ -z "$JWT_SECRET" ]; then
    echo "❌ JWT_SECRET is required in .env file"
    exit 1
fi

if [ -z "$ALLOWED_ORIGINS" ]; then
    echo "❌ ALLOWED_ORIGINS is required in .env file"
    exit 1
fi

echo "✅ Environment variables validated"

# Build and start services
echo "🐳 Building and starting Docker services..."
docker-compose -f docker-compose.prod.yml down --volumes
docker-compose -f docker-compose.prod.yml build --no-cache
docker-compose -f docker-compose.prod.yml up -d

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 30

# Health check
echo "🏥 Performing health checks..."
if curl -f http://localhost/health > /dev/null 2>&1; then
    echo "✅ Frontend is healthy"
else
    echo "❌ Frontend health check failed"
    exit 1
fi

if curl -f http://localhost:${SERVER_PORT:-8080}/api/auth/me > /dev/null 2>&1; then
    echo "✅ Backend is healthy"
else
    echo "❌ Backend health check failed"
    exit 1
fi

echo "🎉 Deployment completed successfully!"
echo "🌐 Frontend: http://localhost"
echo "🔧 Backend: http://localhost:${SERVER_PORT:-8080}"
echo "📊 Database: localhost:${DB_PORT:-5432}"
