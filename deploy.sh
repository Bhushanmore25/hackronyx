#!/bin/bash

echo "🚀 HRX Genius Grid Deployment Script"
echo "====================================="

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "❌ Git repository not found. Please initialize git first:"
    echo "   git init"
    echo "   git add ."
    echo "   git commit -m 'Initial commit'"
    echo "   git remote add origin <your-github-repo-url>"
    echo "   git push -u origin main"
    exit 1
fi

# Check if changes are committed
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  You have uncommitted changes. Please commit them first:"
    echo "   git add ."
    echo "   git commit -m 'Deployment preparation'"
    echo "   git push"
    exit 1
fi

echo "✅ Git repository is ready"

# Check if render.yaml exists
if [ ! -f "render.yaml" ]; then
    echo "❌ render.yaml not found. Please ensure it exists in the root directory."
    exit 1
fi

echo "✅ render.yaml found"

# Display deployment instructions
echo ""
echo "📋 Deployment Instructions:"
echo "=========================="
echo ""
echo "1. Push your code to GitHub:"
echo "   git push origin main"
echo ""
echo "2. Go to Render Dashboard:"
echo "   https://dashboard.render.com"
echo ""
echo "3. Click 'New +' and select 'Blueprint'"
echo ""
echo "4. Connect your GitHub repository"
echo ""
echo "5. Render will automatically detect render.yaml"
echo ""
echo "6. Configure environment variables:"
echo "   - MONGO_URI: Your MongoDB connection string"
echo "   - JWT_SECRET: A secure random string"
echo "   - FRONTEND_URL: https://hrx-genius-grid-frontend.onrender.com"
echo "   - GEMINI_API_KEY: Your Gemini API key (if using)"
echo "   - EMAIL_USER: Your email (if using nodemailer)"
echo "   - EMAIL_PASS: Your email password (if using nodemailer)"
echo ""
echo "7. Deploy!"
echo ""
echo "🔗 Your services will be available at:"
echo "   Backend: https://hrx-genius-grid-backend.onrender.com"
echo "   Frontend: https://hrx-genius-grid-frontend.onrender.com"
echo ""
echo "📖 For detailed instructions, see DEPLOYMENT_GUIDE.md"
echo ""
echo "🎉 Happy deploying!" 