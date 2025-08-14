#!/bin/bash

echo "🚀 Setting up GitHub repository for deployment..."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "📝 Initializing Git repository..."
    git init
else
    echo "✅ Git repository already exists"
fi

# Add all files
echo "📁 Adding files to Git..."
git add .

# Check if there are changes to commit
if git diff --cached --quiet; then
    echo "ℹ️  No changes to commit"
else
    echo "💾 Committing changes..."
    git commit -m "Initial commit - Expense Tracker ready for deployment"
fi

# Get GitHub username
echo ""
echo "🔗 GitHub Setup Instructions:"
echo "=============================="
echo ""
echo "1. Go to https://github.com and sign in"
echo "2. Click 'New repository' (green button)"
echo "3. Repository name: expense-tracker-fullstack"
echo "4. Make it PUBLIC"
echo "5. DON'T initialize with README (we already have one)"
echo "6. Click 'Create repository'"
echo ""
echo "After creating the repository, run these commands:"
echo ""

# Check if remote already exists
if git remote get-url origin &> /dev/null; then
    echo "✅ Remote origin already exists"
    echo "Current remote URL: $(git remote get-url origin)"
    echo ""
    echo "To update remote URL, run:"
    echo "git remote set-url origin https://github.com/YOUR_USERNAME/expense-tracker-fullstack.git"
else
    echo "git remote add origin https://github.com/YOUR_USERNAME/expense-tracker-fullstack.git"
fi

echo "git branch -M main"
echo "git push -u origin main"
echo ""
echo "Replace YOUR_USERNAME with your actual GitHub username!"
echo ""
echo "🎯 Next Steps:"
echo "1. Create GitHub repository (see steps above)"
echo "2. Run the git commands above"
echo "3. Choose your deployment platform:"
echo "   - Render (easiest): Follow RENDER_DEPLOYMENT.md"
echo "   - Fly.io (most generous): Follow FLY_DEPLOYMENT.md"
echo ""
echo "Good luck with your deployment! 🚀"
