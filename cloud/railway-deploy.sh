#!/bin/bash

# Railway FREE Deployment Script
# Simplest deployment option - 5 minutes setup

set -e

echo "🚂 Deploying to Railway (FREE - 5 minutes setup)..."

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
echo "  • Cost: $0 (using free credits)"
echo "  • Setup time: 5 minutes"
echo "  • Auto-deploys on git push"
echo ""
echo "📊 Railway Dashboard:"
echo "  https://railway.app/dashboard"
echo ""
echo "🔧 To update deployment:"
echo "  git push origin main"
echo "  (Railway auto-deploys)"
