@echo off
echo 🚀 Setting up GitHub repository for deployment...

REM Check if git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Git is not installed. Please install Git first.
    echo Download from: https://git-scm.com/download/win
    pause
    exit /b 1
)

REM Check if we're in a git repository
if not exist .git (
    echo 📝 Initializing Git repository...
    git init
) else (
    echo ✅ Git repository already exists
)

REM Add all files
echo 📁 Adding files to Git...
git add .

REM Check if there are changes to commit
git diff --cached --quiet
if %errorlevel% neq 0 (
    echo 💾 Committing changes...
    git commit -m "Initial commit - Expense Tracker ready for deployment"
) else (
    echo ℹ️  No changes to commit
)

echo.
echo 🔗 GitHub Setup Instructions:
echo ==============================
echo.
echo 1. Go to https://github.com and sign in
echo 2. Click 'New repository' (green button)
echo 3. Repository name: expense-tracker-fullstack
echo 4. Make it PUBLIC
echo 5. DON'T initialize with README (we already have one)
echo 6. Click 'Create repository'
echo.
echo After creating the repository, run these commands:
echo.

REM Check if remote already exists
git remote get-url origin >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Remote origin already exists
    echo Current remote URL:
    git remote get-url origin
    echo.
    echo To update remote URL, run:
    echo git remote set-url origin https://github.com/YOUR_USERNAME/expense-tracker-fullstack.git
) else (
    echo git remote add origin https://github.com/YOUR_USERNAME/expense-tracker-fullstack.git
)

echo git branch -M main
echo git push -u origin main
echo.
echo Replace YOUR_USERNAME with your actual GitHub username!
echo.
echo 🎯 Next Steps:
echo 1. Create GitHub repository (see steps above)
echo 2. Run the git commands above
echo 3. Choose your deployment platform:
echo    - Render (easiest): Follow RENDER_DEPLOYMENT.md
echo    - Fly.io (most generous): Follow FLY_DEPLOYMENT.md
echo.
echo Good luck with your deployment! 🚀
pause
