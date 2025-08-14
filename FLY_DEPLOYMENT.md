# 🚀 Fly.io Deployment Guide (Most Generous Free Tier)

Fly.io offers the most generous free tier with 3 shared-cpu VMs and 3GB persistent volume.

## 📋 Prerequisites

- **GitHub Account**: To host your code
- **Fly.io Account**: Sign up at [fly.io](https://fly.io)
- **Credit Card**: Required for verification (no charges on free tier)

## 🔄 Step 1: Push Code to GitHub

Same as Render guide - push your code to GitHub first.

## 🛠️ Step 2: Install Fly CLI

### **Windows (PowerShell):**
```powershell
iwr https://fly.io/install.ps1 -useb | iex
```

### **macOS/Linux:**
```bash
curl -L https://fly.io/install.sh | sh
```

### **Verify Installation:**
```bash
fly version
```

## 🔐 Step 3: Sign Up and Login

### **3.1 Sign Up:**
1. Go to [fly.io](https://fly.io)
2. Click "Get Started"
3. Sign up with GitHub
4. Verify your email

### **3.2 Login via CLI:**
```bash
fly auth login
```

## 🗄️ Step 4: Deploy Database

### **4.1 Create Database App:**
```bash
fly apps create expense-tracker-db
```

### **4.2 Deploy PostgreSQL:**
```bash
fly postgres create --name expense-tracker-db --region iad
```

### **4.3 Attach to App:**
```bash
fly postgres attach expense-tracker-db --app expense-tracker-db
```

## 🔧 Step 5: Deploy Backend

### **5.1 Create Backend App:**
```bash
fly apps create expense-tracker-api
```

### **5.2 Create fly.toml for Backend:**
```toml
# backend/fly.toml
app = "expense-tracker-api"
primary_region = "iad"

[build]
  dockerfile = "Dockerfile"

[env]
  DB_HOST = "expense-tracker-db.internal"
  DB_PORT = "5432"
  DB_NAME = "expensetracker"
  DB_USER = "postgres"
  JPA_DDL_AUTO = "update"
  JPA_SHOW_SQL = "false"
  H2_CONSOLE_ENABLED = "false"
  JWT_SECRET = "ExpenseTrackerJWTSecretKey2024!ThisIsAVeryLongAndSecureKeyForProductionUseWithMinimum256Bits"
  JWT_EXPIRATION_MS = "86400000"
  SERVER_PORT = "8080"
  ALLOWED_ORIGINS = "https://expense-tracker-frontend.fly.dev"

[[services]]
  internal_port = 8080
  protocol = "tcp"

  [[services.ports]]
    port = 80
    handlers = ["http"]
    force_https = true

  [[services.ports]]
    port = 443
    handlers = ["tls", "http"]
```

### **5.3 Deploy Backend:**
```bash
cd backend
fly deploy
```

## 🌐 Step 6: Deploy Frontend

### **6.1 Create Frontend App:**
```bash
fly apps create expense-tracker-frontend
```

### **6.2 Create fly.toml for Frontend:**
```toml
# frontend/fly.toml
app = "expense-tracker-frontend"
primary_region = "iad"

[build]
  dockerfile = "Dockerfile"

[env]
  VITE_API_BASE = "https://expense-tracker-api.fly.dev"

[[services]]
  internal_port = 80
  protocol = "tcp"

  [[services.ports]]
    port = 80
    handlers = ["http"]
    force_https = true

  [[services.ports]]
    port = 443
    handlers = ["tls", "http"]
```

### **6.3 Deploy Frontend:**
```bash
cd frontend
fly deploy
```

## 🔍 Step 7: Verify Deployment

### **7.1 Check App Status:**
```bash
fly apps list
fly status -a expense-tracker-api
fly status -a expense-tracker-frontend
```

### **7.2 Test Your Application:**
- **Frontend**: `https://expense-tracker-frontend.fly.dev`
- **Backend**: `https://expense-tracker-api.fly.dev`

## 💰 Free Tier Limits

- **3 shared-cpu VMs** (1GB RAM each)
- **3GB persistent volume**
- **160GB outbound data transfer**
- **Perfect for small to medium applications**

## 🎯 Advantages of Fly.io

- **Global deployment** (choose regions)
- **Very generous free tier**
- **Automatic SSL certificates**
- **Built-in monitoring**
- **Fast deployments**

## 🔧 Troubleshooting

### **Common Issues:**

#### **Database Connection:**
```bash
# Check database status
fly status -a expense-tracker-db

# View logs
fly logs -a expense-tracker-api
```

#### **Build Failures:**
```bash
# Check build logs
fly logs -a expense-tracker-api

# Rebuild
fly deploy --force
```

#### **Memory Issues:**
```bash
# Check resource usage
fly status -a expense-tracker-api

# Scale if needed
fly scale memory 512 -a expense-tracker-api
```

## 🏆 Success!

Your app is now deployed on Fly.io with:
- ✅ **Global availability**
- ✅ **Automatic SSL**
- ✅ **Generous free tier**
- ✅ **Professional hosting**
- ✅ **Portfolio ready**
