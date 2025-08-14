@echo off
echo 🧪 Testing local development setup...

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not running. Please start Docker first.
    pause
    exit /b 1
)

REM Start database
echo 🐳 Starting PostgreSQL database...
docker-compose up -d postgres

REM Wait for database to be ready
echo ⏳ Waiting for database to be ready...
timeout /t 10 /nobreak >nul

REM Test database connection
docker exec expense_pg pg_isready -U expensetracker >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Database connection failed
    pause
    exit /b 1
) else (
    echo ✅ Database is ready
)

REM Test backend build
echo 🔨 Testing backend build...
cd backend
call mvnw clean compile -q
if %errorlevel% neq 0 (
    echo ❌ Backend compilation failed
    pause
    exit /b 1
) else (
    echo ✅ Backend compiles successfully
)
cd ..

REM Test frontend build
echo 🔨 Testing frontend build...
cd frontend
call npm run build >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Frontend build failed
    pause
    exit /b 1
) else (
    echo ✅ Frontend builds successfully
)
cd ..

echo 🎉 All tests passed! Your local setup is ready.
echo 🚀 To start development:
echo    Backend: cd backend ^&^& mvnw spring-boot:run
echo    Frontend: cd frontend ^&^& npm run dev
echo    Database: Already running via docker-compose
pause
