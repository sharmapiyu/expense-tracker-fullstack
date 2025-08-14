# 💰 Expense Tracker Fullstack Application

A modern, full-stack expense tracking application built with Spring Boot (Java 21) and React (Vite).

## 🚀 Features

- **User Authentication**: JWT-based login/registration
- **Expense Management**: Add, edit, delete, and view expenses
- **Responsive UI**: Modern interface built with Tailwind CSS
- **Secure API**: Spring Security with JWT authentication
- **Database**: PostgreSQL with JPA/Hibernate
- **Docker Ready**: Complete containerization setup

## 🏗️ Architecture

- **Backend**: Spring Boot 3.5.4 + Java 21 + Spring Security + JWT
- **Frontend**: React 18 + Vite + Tailwind CSS
- **Database**: PostgreSQL 16
- **Containerization**: Docker + Docker Compose

## 📋 Prerequisites

- Java 21 or higher
- Node.js 18 or higher
- Docker and Docker Compose
- PostgreSQL (if running locally)

## 🛠️ Local Development Setup

### 1. Clone the repository
```bash
git clone <your-repo-url>
cd expense_tracker_fullstack
```

### 2. Start the database
```bash
docker-compose up -d postgres
```

### 3. Backend Setup
```bash
cd backend
# Update application.properties with your database credentials
mvn spring-boot:run
```

### 4. Frontend Setup
```bash
cd frontend
npm install
npm run dev
```

The application will be available at:
- Frontend: http://localhost:5173
- Backend: http://localhost:8080
- Database: localhost:5432

## 🚀 Production Deployment

### 🌟 **Free Cloud Deployment Options**

Your application is ready for free deployment on multiple platforms:

#### **Option 1: Render (Recommended - Easiest)**
- **Free Tier**: Generous free hosting
- **Features**: Automatic SSL, PostgreSQL database, global CDN
- **Guide**: [RENDER_DEPLOYMENT.md](RENDER_DEPLOYMENT.md)

#### **Option 2: Fly.io (Most Generous Free Tier)**
- **Free Tier**: 3 shared-cpu VMs, 3GB persistent volume
- **Features**: Global deployment, automatic SSL, built-in monitoring
- **Guide**: [FLY_DEPLOYMENT.md](FLY_DEPLOYMENT.md)

### **Quick Deployment Steps:**

1. **Setup GitHub Repository:**
   ```bash
   # Windows
   setup-github.bat
   
   # Linux/Mac
   ./setup-github.sh
   ```

2. **Choose Platform & Deploy:**
   - **Render**: Follow [RENDER_DEPLOYMENT.md](RENDER_DEPLOYMENT.md)
   - **Fly.io**: Follow [FLY_DEPLOYMENT.md](FLY_DEPLOYMENT.md)

3. **Your App Goes Live!** 🎉

### **Local Production Deployment**
```bash
# Using deployment script
./deploy.sh

# Manual deployment
docker-compose -f docker-compose.prod.yml up -d --build
```

## 🔧 Configuration

### Backend Configuration
- Database connection settings in `application.properties`
- JWT configuration via environment variables
- CORS settings for production domains

### Frontend Configuration
- API base URL in `src/api.js`
- Environment variables for production builds

## 📊 API Endpoints

### Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login
- `GET /api/auth/me` - Get current user

### Expenses
- `GET /api/expenses` - List user expenses
- `POST /api/expenses` - Create new expense
- `PUT /api/expenses/{id}` - Update expense
- `DELETE /api/expenses/{id}` - Delete expense

## 🔒 Security Features

- JWT-based authentication
- Password encryption with BCrypt
- CORS configuration
- Input validation
- SQL injection protection via JPA

## 🐳 Docker Services

- **postgres**: PostgreSQL database
- **backend**: Spring Boot application
- **frontend**: React application with Nginx

## 📝 Development Notes

- The application uses lazy loading for user relationships
- JWT tokens are stored in localStorage
- All API calls include proper error handling
- Responsive design works on mobile and desktop

## 🚨 Troubleshooting

### Common Issues

1. **Database Connection Failed**
   - Check if PostgreSQL is running
   - Verify database credentials in `.env`

2. **CORS Errors**
   - Ensure `ALLOWED_ORIGINS` includes your frontend domain
   - Check browser console for specific CORS errors

3. **JWT Token Issues**
   - Verify `JWT_SECRET` is set and secure
   - Check token expiration settings

### Logs
```bash
# View all service logs
docker-compose -f docker-compose.prod.yml logs -f

# View specific service logs
docker-compose -f docker-compose.prod.yml logs -f backend
```

## 📈 Performance Optimization

- Frontend assets are compressed with gzip
- Static files have long-term caching
- API rate limiting is configured
- Database connection pooling

## 🔄 Updates and Maintenance

To update the application:
```bash
git pull origin main
./deploy.sh
```

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📞 Support

For issues and questions:
- Create an issue in the repository
- Check the troubleshooting section above
- Review the logs for error details

---

## 🏆 **Ready for Portfolio!**

Your Expense Tracker is now:
- ✅ **Production Ready** with Docker containerization
- ✅ **Free Cloud Deployment** guides included
- ✅ **Professional Documentation** for employers
- ✅ **Modern Tech Stack** (Java 21 + React 18)
- ✅ **Security Best Practices** implemented

**Deploy it for free and showcase it in your portfolio!** 🚀
