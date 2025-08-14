# 🚀 Production Deployment Guide

This guide will walk you through deploying your Expense Tracker application to production.

## 📋 Prerequisites

- **VPS/Cloud Server**: Ubuntu 20.04+ or similar Linux distribution
- **Domain Name**: For SSL certificates and public access
- **Docker & Docker Compose**: For containerization
- **Basic Linux knowledge**: For server management

## 🌐 Deployment Options

### Option 1: VPS/Cloud Server (Recommended)
- **Providers**: DigitalOcean, AWS EC2, Google Cloud, Azure
- **Cost**: $5-20/month for basic setup
- **Control**: Full control over the environment

### Option 2: Platform as a Service
- **Providers**: Heroku, Railway, Render
- **Cost**: Free tier available, then $5-20/month
- **Control**: Limited, but easier deployment

### Option 3: Shared Hosting
- **Providers**: Hostinger, Bluehost, etc.
- **Cost**: $3-10/month
- **Control**: Very limited, not recommended for this app

## 🖥️ Server Setup (VPS Option)

### 1. Initial Server Setup
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y curl wget git unzip

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add user to docker group
sudo usermod -aG docker $USER
```

### 2. Clone Your Repository
```bash
git clone <your-repo-url>
cd expense_tracker_fullstack
```

### 3. Configure Environment
```bash
# Copy and edit environment file
cp env.production .env
nano .env

# Update with your production values:
DB_PASSWORD=YourVerySecurePassword123!
JWT_SECRET=YourVeryLongJWTSecretKeyForProductionUseWithMinimum256Bits
ALLOWED_ORIGINS=https://yourdomain.com,https://www.yourdomain.com
```

## 🔒 SSL/HTTPS Setup

### 1. Install Certbot
```bash
sudo apt install -y certbot python3-certbot-nginx
```

### 2. Get SSL Certificate
```bash
sudo certbot certonly --standalone -d yourdomain.com -d www.yourdomain.com
```

### 3. Update Nginx Configuration
Edit `frontend/nginx.conf` to include SSL:
```nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com www.yourdomain.com;
    
    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;
    
    # ... rest of your config
}
```

## 🚀 Deploy Application

### 1. Build and Start Services
```bash
# Make deploy script executable
chmod +x deploy.sh

# Deploy
./deploy.sh
```

### 2. Verify Deployment
```bash
# Check service status
docker-compose -f docker-compose.prod.yml ps

# Check logs
docker-compose -f docker-compose.prod.yml logs -f

# Test endpoints
curl http://localhost/health
curl http://localhost:8080/api/auth/me
```

## 🔧 Production Optimizations

### 1. Database Optimization
```bash
# Add to docker-compose.prod.yml
postgres:
  environment:
    POSTGRES_DB: ${DB_NAME:-expensetracker}
    POSTGRES_USER: ${DB_USER:-expensetracker}
    POSTGRES_PASSWORD: ${DB_PASSWORD}
    # Performance tuning
    POSTGRES_SHARED_BUFFERS: 256MB
    POSTGRES_EFFECTIVE_CACHE_SIZE: 1GB
    POSTGRES_WORK_MEM: 4MB
```

### 2. Backend Optimization
```bash
# Add to .env
JVM_OPTS=-Xmx512m -Xms256m -XX:+UseG1GC
```

### 3. Frontend Optimization
```bash
# Update frontend/Dockerfile
RUN npm ci --only=production && npm run build
```

## 📊 Monitoring & Maintenance

### 1. Health Checks
```bash
# Create health check script
cat > health-check.sh << 'EOF'
#!/bin/bash
FRONTEND=$(curl -s -o /dev/null -w "%{http_code}" https://yourdomain.com/health)
BACKEND=$(curl -s -o /dev/null -w "%{http_code}" https://yourdomain.com/api/auth/me)

if [ "$FRONTEND" = "200" ] && [ "$BACKEND" = "401" ]; then
    echo "✅ All services healthy"
else
    echo "❌ Service issues detected"
    exit 1
fi
EOF

chmod +x health-check.sh
```

### 2. Automated Backups
```bash
# Create backup script
cat > backup.sh << 'EOF'
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backups"

mkdir -p $BACKUP_DIR

# Database backup
docker exec expense_pg_prod pg_dump -U expensetracker expensetracker > $BACKUP_DIR/db_backup_$DATE.sql

# Keep only last 7 backups
find $BACKUP_DIR -name "db_backup_*.sql" -mtime +7 -delete

echo "Backup completed: db_backup_$DATE.sql"
EOF

chmod +x backup.sh

# Add to crontab (daily at 2 AM)
echo "0 2 * * * /path/to/your/project/backup.sh" | crontab -
```

### 3. Log Rotation
```bash
# Create logrotate config
sudo tee /etc/logrotate.d/expense-tracker << 'EOF'
/var/log/expense-tracker/*.log {
    daily
    missingok
    rotate 30
    compress
    delaycompress
    notifempty
    create 644 root root
    postrotate
        docker-compose -f /path/to/your/project/docker-compose.prod.yml restart nginx
    endscript
}
EOF
```

## 🚨 Troubleshooting

### Common Issues

1. **Port Already in Use**
   ```bash
   # Check what's using the port
   sudo netstat -tulpn | grep :80
   
   # Stop conflicting service
   sudo systemctl stop nginx
   ```

2. **Database Connection Issues**
   ```bash
   # Check database logs
   docker-compose -f docker-compose.prod.yml logs postgres
   
   # Test connection
   docker exec expense_pg_prod psql -U expensetracker -d expensetracker
   ```

3. **Memory Issues**
   ```bash
   # Check memory usage
   docker stats
   
   # Restart services
   docker-compose -f docker-compose.prod.yml restart
   ```

## 🔄 Updates & Maintenance

### 1. Application Updates
```bash
# Pull latest changes
git pull origin main

# Rebuild and restart
./deploy.sh
```

### 2. SSL Certificate Renewal
```bash
# Test renewal
sudo certbot renew --dry-run

# Add to crontab (twice daily)
echo "0 12,0 * * * /usr/bin/certbot renew --quiet" | crontab -
```

### 3. System Updates
```bash
# Weekly system updates
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
```

## 📈 Performance Monitoring

### 1. Resource Monitoring
```bash
# Install monitoring tools
sudo apt install -y htop iotop nethogs

# Monitor in real-time
htop
```

### 2. Application Metrics
```bash
# Check container resource usage
docker stats

# Monitor logs
docker-compose -f docker-compose.prod.yml logs -f --tail=100
```

## 🎯 Next Steps

1. **Set up monitoring**: Consider Prometheus + Grafana
2. **Implement CI/CD**: GitHub Actions or GitLab CI
3. **Add load balancing**: For high-traffic scenarios
4. **Database clustering**: For high availability
5. **CDN integration**: For global performance

## 📞 Support

- **Documentation**: Check README.md first
- **Issues**: Create GitHub issues
- **Community**: Stack Overflow, Reddit r/devops
- **Professional**: Consider hiring a DevOps engineer for complex setups

---

**Remember**: Always test in staging environment first, and keep regular backups!
