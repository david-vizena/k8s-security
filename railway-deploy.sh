#!/bin/bash

# Railway Deployment Script
# 100% FREE deployment for Project 4

set -e

echo "🚂 Deploying to Railway (100% FREE)..."

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "📦 Installing Railway CLI..."
    npm install -g @railway/cli
fi

# Check if user is logged in
if ! railway whoami &> /dev/null; then
    echo "🔐 Please login to Railway:"
    railway login
fi

# Initialize Railway project
echo "🚀 Initializing Railway project..."
railway init

# Set environment variables
echo "⚙️ Setting environment variables..."
railway variables set NODE_ENV=production
railway variables set PORT=8080

# Deploy
echo "🚀 Deploying to Railway..."
railway up

# Get deployment URL
echo "🌐 Getting deployment URL..."
DEPLOYMENT_URL=$(railway domain)

echo "✅ Application deployed!"
echo "🌐 Access your app at: https://$DEPLOYMENT_URL"
echo ""
echo "🎯 Railway Deployment Summary:"
echo "  • Application: https://$DEPLOYMENT_URL"
echo "  • Cost: $0 (100% FREE)"
echo "  • Setup time: 5 minutes"
echo "  • Auto-deploys on git push"
echo ""
echo "📊 Railway Dashboard:"
echo "  https://railway.app/dashboard"
echo ""
echo "🔧 To update deployment:"
echo "  git push origin main"
echo "  (Railway auto-deploys)"
echo ""
echo "🎉 Perfect for showcasing to employers!"
