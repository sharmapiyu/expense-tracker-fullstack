#!/bin/bash

echo "🧪 Testing local development setup..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Start database
echo "🐳 Starting PostgreSQL database..."
docker-compose up -d postgres

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
sleep 10

# Test database connection
if docker exec expense_pg pg_isready -U expensetracker > /dev/null 2>&1; then
    echo "✅ Database is ready"
else
    echo "❌ Database connection failed"
    exit 1
fi

# Test backend build
echo "🔨 Testing backend build..."
cd backend
if ./mvnw clean compile -q; then
    echo "✅ Backend compiles successfully"
else
    echo "❌ Backend compilation failed"
    exit 1
fi
cd ..

# Test frontend build
echo "🔨 Testing frontend build..."
cd frontend
if npm run build > /dev/null 2>&1; then
    echo "✅ Frontend builds successfully"
else
    echo "❌ Frontend build failed"
    exit 1
fi
cd ..

echo "🎉 All tests passed! Your local setup is ready."
echo "🚀 To start development:"
echo "   Backend: cd backend && ./mvnw spring-boot:run"
echo "   Frontend: cd frontend && npm run dev"
echo "   Database: Already running via docker-compose"
