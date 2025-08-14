# 🚀 Render Deployment Guide (Free Tier)

This guide will walk you through deploying your Expense Tracker to Render's free tier.

## 📋 Prerequisites

- **GitHub Account**: To host your code
- **Render Account**: Sign up at [render.com](https://render.com)
- **Credit Card**: Required for verification (no charges on free tier)

## 🔄 Step 1: Push Code to GitHub

### 1.1 Initialize Git Repository
```bash
git init
git add .
git commit -m "Initial commit - Expense Tracker ready for deployment"
```

### 1.2 Create GitHub Repository
1. Go to [github.com](https://github.com)
2. Click "New repository"
3. Name it: `expense-tracker-fullstack`
4. Make it public
5. Don't initialize with README (we already have one)

### 1.3 Push to GitHub
```bash
git remote add origin https://github.com/YOUR_USERNAME/expense-tracker-fullstack.git
git branch -M main
git push -u origin main
```

## 🌐 Step 2: Deploy on Render

### 2.1 Sign Up for Render
1. Go to [render.com](https://render.com)
2. Click "Get Started for Free"
3. Sign up with GitHub (recommended)
4. Verify your email

### 2.2 Deploy Using Blueprint (Easiest Method)

1. **Click "New +"** in your Render dashboard
2. **Select "Blueprint"**
3. **Connect your GitHub repository**
4. **Select the repository**: `expense-tracker-fullstack`
5. **Render will automatically detect the `render.yaml` file**
6. **Click "Apply"**

### 2.3 Manual Deployment (Alternative)

If blueprint doesn't work, deploy services manually:

#### **Database First:**
1. Click "New +" → "PostgreSQL"
2. **Name**: `expense-tracker-db`
3. **Database**: `expensetracker`
4. **User**: `expensetracker`
5. **Region**: Choose closest to you
6. **Plan**: Free
7. Click "Create Database"

#### **Backend API:**
1. Click "New +" → "Web Service"
2. **Name**: `expense-tracker-api`
3. **Environment**: Docker
4. **Region**: Same as database
5. **Branch**: `main`
6. **Root Directory**: Leave empty
7. **Dockerfile Path**: `backend/Dockerfile`
8. **Docker Context**: `backend`
9. **Plan**: Free

**Environment Variables:**
```
DB_HOST=<database-host-from-database-service>
DB_PORT=<database-port-from-database-service>
DB_NAME=expensetracker
DB_USER=expensetracker
DB_PASSWORD=<database-password-from-database-service>
JPA_DDL_AUTO=update
JPA_SHOW_SQL=false
H2_CONSOLE_ENABLED=false
JWT_SECRET=ExpenseTrackerJWTSecretKey2024!ThisIsAVeryLongAndSecureKeyForProductionUseWithMinimum256Bits
JWT_EXPIRATION_MS=86400000
SERVER_PORT=8080
ALLOWED_ORIGINS=https://expense-tracker-frontend.onrender.com
```

#### **Frontend:**
1. Click "New +" → "Static Site"
2. **Name**: `expense-tracker-frontend`
3. **Build Command**: `cd frontend && npm install && npm run build`
4. **Publish Directory**: `frontend/dist`
5. **Plan**: Free

**Environment Variables:**
```
VITE_API_BASE=https://expense-tracker-api.onrender.com
```

## ⏳ Step 3: Wait for Deployment

- **Database**: 2-5 minutes
- **Backend**: 5-10 minutes (first time)
- **Frontend**: 2-3 minutes

## 🔍 Step 4: Verify Deployment

### 4.1 Check Service Status
- All services should show "Live" status
- Note down the URLs provided

### 4.2 Test Your Application
1. **Frontend URL**: `https://expense-tracker-frontend.onrender.com`
2. **Backend URL**: `https://expense-tracker-api.onrender.com`
3. **Database**: Managed by Render

### 4.3 Test Functionality
1. Open frontend URL
2. Register a new user
3. Login
4. Add an expense
5. Test edit/delete functionality

## 🔧 Step 5: Troubleshooting

### Common Issues:

#### **Backend Won't Start:**
- Check environment variables
- Verify database connection
- Check logs in Render dashboard

#### **Frontend Build Fails:**
- Ensure all dependencies are in `package.json`
- Check build command
- Verify Node.js version compatibility

#### **Database Connection Issues:**
- Verify database credentials
- Check if database is running
- Ensure correct host/port

### **View Logs:**
1. Go to your service in Render dashboard
2. Click on the service name
3. Go to "Logs" tab
4. Check for error messages

## 📱 Step 6: Update Your Portfolio

### **Add to README.md:**
```markdown
## 🌐 Live Demo

- **Frontend**: [https://expense-tracker-frontend.onrender.com](https://expense-tracker-frontend.onrender.com)
- **Backend API**: [https://expense-tracker-api.onrender.com](https://expense-tracker-api.onrender.com)

## 🚀 Deployment

This application is deployed on Render's free tier using:
- PostgreSQL database
- Docker containerization
- Automatic SSL certificates
- Global CDN
```

### **Add to Portfolio:**
- Screenshots of your running application
- Link to the live demo
- Mention the technologies used
- Highlight the deployment process

## 💰 Cost Breakdown (Free Tier)

- **Database**: $0/month (free tier)
- **Backend API**: $0/month (free tier)
- **Frontend**: $0/month (free tier)
- **Total**: $0/month

## 🔄 Updates and Maintenance

### **Automatic Deployments:**
- Render automatically redeploys when you push to GitHub
- No manual intervention needed

### **Manual Updates:**
1. Make changes locally
2. Push to GitHub
3. Render automatically rebuilds and deploys

### **Monitoring:**
- Check Render dashboard regularly
- Monitor service health
- Review logs for any issues

## 🎯 Next Steps

1. **Custom Domain**: Add your own domain name
2. **SSL Certificate**: Automatically provided by Render
3. **Monitoring**: Set up alerts for downtime
4. **Backups**: Database backups are automatic
5. **Scaling**: Upgrade to paid plans when needed

## 🏆 Success!

Your Expense Tracker is now:
- ✅ **Live on the internet**
- ✅ **Accessible from anywhere**
- ✅ **Free to host**
- ✅ **Ready for your portfolio**
- ✅ **Automatically deployed**

**Congratulations! You now have a professional, deployed application to showcase!** 🎉
