#!/bin/bash

echo "🚀 Quick Start - Expense Tracker"
echo "================================="

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check if .env exists
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp env.production .env
    echo "✅ .env file created. Please edit it with your preferred values."
fi

# Start database
echo "🐳 Starting PostgreSQL database..."
docker-compose up -d postgres

# Wait for database
echo "⏳ Waiting for database to be ready..."
sleep 15

# Check database status
if docker exec expense_pg pg_isready -U expensetracker > /dev/null 2>&1; then
    echo "✅ Database is ready!"
else
    echo "❌ Database failed to start. Check logs with: docker-compose logs postgres"
    exit 1
fi

echo ""
echo "🎉 Setup complete! Your database is running."
echo ""
echo "📱 Next steps:"
echo "   1. Backend: cd backend && ./mvnw spring-boot:run"
echo "   2. Frontend: cd frontend && npm run dev"
echo "   3. Database: Already running (localhost:5432)"
echo ""
echo "🌐 Access points:"
echo "   - Frontend: http://localhost:5173"
echo "   - Backend: http://localhost:8080"
echo "   - Database: localhost:5432"
echo ""
echo "🔧 To stop database: docker-compose down"
echo "📊 To view logs: docker-compose logs -f"
