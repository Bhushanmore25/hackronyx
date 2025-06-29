# Complete Deployment Guide for HRX Genius Grid (MERN Stack)

## Prerequisites
1. A Render account (free tier available)
2. A MongoDB database (MongoDB Atlas recommended)
3. Your environment variables ready
4. GitHub repository with your code

## Project Structure
```
HRX-26-GENIUS-GRID-main/
├── backend/          # Node.js/Express backend
├── frontend/         # React/Vite frontend
├── render.yaml       # Render deployment configuration
└── DEPLOYMENT_GUIDE.md
```

## Step 1: Prepare Your Environment Variables

### Backend Environment Variables (Required):
- `MONGO_URI`: Your MongoDB connection string
- `JWT_SECRET`: A secure random string for JWT token signing
- `FRONTEND_URL`: Your frontend application URL (for CORS)

### Backend Environment Variables (Optional):
- `GEMINI_API_KEY`: If using Gemini AI features
- `EMAIL_USER`: Email address for nodemailer
- `EMAIL_PASS`: Email password/app password for nodemailer

### Frontend Environment Variables:
- `VITE_API_URL`: Your backend API URL (will be set automatically)

## Step 2: Deploy Using Blueprint (Recommended)

### Option A: One-Click Deployment with render.yaml
1. **Push your code to GitHub** (if not already done)
2. **Go to [Render Dashboard](https://dashboard.render.com)**
3. **Click "New +" and select "Blueprint"**
4. **Connect your GitHub repository**
5. **Render will automatically detect the `render.yaml` file**
6. **Configure your environment variables in the dashboard**
7. **Deploy!**

### Option B: Manual Deployment

#### Deploy Backend First:
1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click "New +" and select "Web Service"
3. Connect your GitHub repository
4. Configure the backend service:
   - **Name**: `hrx-genius-grid-backend`
   - **Environment**: `Node`
   - **Build Command**: `cd backend && npm install`
   - **Start Command**: `cd backend && npm start`
   - **Plan**: Free (or choose paid plan)

#### Deploy Frontend:
1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click "New +" and select "Static Site"
3. Connect your GitHub repository
4. Configure the frontend service:
   - **Name**: `hrx-genius-grid-frontend`
   - **Build Command**: `cd frontend && npm install && npm run build`
   - **Publish Directory**: `frontend/dist`
   - **Plan**: Free (or choose paid plan)

## Step 3: Configure Environment Variables

### Backend Environment Variables:
In your backend service dashboard:
1. Go to "Environment" tab
2. Add each environment variable:
   ```
   MONGO_URI=mongodb+srv://username:password@cluster.mongodb.net/database
   JWT_SECRET=your-super-secret-jwt-key
   FRONTEND_URL=https://hrx-genius-grid-frontend.onrender.com
   NODE_ENV=production
   GEMINI_API_KEY=your-gemini-api-key (if using)
   EMAIL_USER=your-email@gmail.com (if using)
   EMAIL_PASS=your-app-password (if using)
   ```

### Frontend Environment Variables:
The frontend will automatically use the backend URL from the render.yaml configuration.

## Step 4: Update Backend CORS Configuration

After getting your frontend URL, update the backend CORS configuration:

```javascript
// In backend/server.js
const allowedOrigins = [
  "http://localhost:5173",
  "http://localhost:3000",
  "https://hrx-genius-grid-frontend.onrender.com", // Your frontend URL
  process.env.FRONTEND_URL
];
```

## Step 5: Test Your Deployment

### Backend Testing:
1. Visit your backend URL: `https://hrx-genius-grid-backend.onrender.com`
2. You should see: `{"message": "HRX Genius Grid Backend API"}`
3. Test the health endpoint: `https://hrx-genius-grid-backend.onrender.com/health`
4. Test your API endpoints

### Frontend Testing:
1. Visit your frontend URL: `https://hrx-genius-grid-frontend.onrender.com`
2. Test all functionality
3. Verify API calls are working

## Step 6: Domain Configuration (Optional)

### Custom Domain Setup:
1. In your Render dashboard, go to your service
2. Click on "Settings" tab
3. Scroll to "Custom Domains"
4. Add your custom domain
5. Update DNS records as instructed

## Important Notes

### CORS Configuration
The backend is configured to allow requests from:
- `http://localhost:5173` (development)
- `http://localhost:3000` (development)
- Your frontend domain (set via `FRONTEND_URL`)

### Database
- Use MongoDB Atlas for production database
- Ensure your MongoDB cluster allows connections from anywhere (0.0.0.0/0) or specifically from Render's IP ranges

### Free Tier Limitations
- Render free tier has cold starts (first request may be slow)
- Limited bandwidth and build minutes
- Consider upgrading for production use

### Build Process
- Frontend: Vite builds to `dist` folder
- Backend: Node.js runs directly
- Both services are automatically built and deployed

## Troubleshooting

### Common Issues:

1. **Build fails**:
   - Check if all dependencies are in `package.json`
   - Verify Node.js version compatibility
   - Check build logs in Render dashboard

2. **Database connection fails**:
   - Verify `MONGO_URI` is correct and accessible
   - Check MongoDB Atlas network access settings

3. **CORS errors**:
   - Update `FRONTEND_URL` in backend environment variables
   - Verify frontend URL is correct

4. **API calls failing**:
   - Check if `VITE_API_URL` is set correctly in frontend
   - Verify backend is running and accessible

5. **Port issues**:
   - Backend automatically uses `process.env.PORT` provided by Render
   - Frontend is served as static files

### Logs
Check Render logs in the dashboard for detailed error information:
- Backend: Go to backend service → "Logs" tab
- Frontend: Go to frontend service → "Logs" tab

## Security Considerations

1. **Environment Variables**:
   - Never commit `.env` files to version control
   - Use strong, unique JWT secrets
   - Keep API keys secure

2. **Database Security**:
   - Enable MongoDB authentication
   - Use strong passwords
   - Consider IP whitelisting

3. **CORS Security**:
   - Only allow necessary origins
   - Use environment variables for URLs

4. **HTTPS**:
   - Render automatically provides HTTPS
   - All communication should be over HTTPS

## Performance Optimization

1. **Frontend**:
   - Vite builds optimized bundles
   - Static files are served efficiently
   - Consider CDN for better performance

2. **Backend**:
   - Implement caching where appropriate
   - Optimize database queries
   - Consider connection pooling

## Monitoring and Maintenance

1. **Health Checks**:
   - Backend has `/health` endpoint
   - Monitor service uptime
   - Set up alerts for downtime

2. **Logs**:
   - Monitor application logs
   - Set up error tracking
   - Regular log analysis

3. **Updates**:
   - Keep dependencies updated
   - Regular security patches
   - Monitor for breaking changes

## Support

If you encounter issues:
1. Check Render documentation
2. Review application logs
3. Verify environment variables
4. Test locally first
5. Contact Render support if needed 