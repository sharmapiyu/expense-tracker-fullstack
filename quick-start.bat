@echo off
echo 🚀 Quick Start - Expense Tracker
echo =================================

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not running. Please start Docker first.
    pause
    exit /b 1
)

REM Check if .env exists
if not exist .env (
    echo 📝 Creating .env file from template...
    copy env.production .env
    echo ✅ .env file created. Please edit it with your preferred values.
)

REM Start database
echo 🐳 Starting PostgreSQL database...
docker-compose up -d postgres

REM Wait for database
echo ⏳ Waiting for database to be ready...
timeout /t 15 /nobreak >nul

REM Check database status
docker exec expense_pg pg_isready -U expensetracker >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Database failed to start. Check logs with: docker-compose logs postgres
    pause
    exit /b 1
) else (
    echo ✅ Database is ready!
)

echo.
echo 🎉 Setup complete! Your database is running.
echo.
echo 📱 Next steps:
echo    1. Backend: cd backend ^&^& mvnw spring-boot:run
echo    2. Frontend: cd frontend ^&^& npm run dev
echo    3. Database: Already running (localhost:5432)
echo.
echo 🌐 Access points:
echo    - Frontend: http://localhost:5173
echo    - Backend: http://localhost:8080
echo    - Database: localhost:5432
echo.
echo 🔧 To stop database: docker-compose down
echo 📊 To view logs: docker-compose logs -f
pause
