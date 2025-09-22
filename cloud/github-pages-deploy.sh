#!/bin/bash

# GitHub Pages FREE Deployment Script
# Deploy React frontend to GitHub Pages (completely free)

set -e

echo "🐙 Deploying to GitHub Pages (FREE - React frontend)..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Not in a git repository. Please initialize git first:"
    echo "   git init"
    echo "   git remote add origin https://github.com/yourusername/k8s-security.git"
    exit 1
fi

# Install gh-pages package
echo "📦 Installing gh-pages package..."
npm install --save-dev gh-pages

# Add deploy script to package.json
echo "⚙️ Adding deploy script to package.json..."
npm pkg set scripts.predeploy="npm run build"
npm pkg set scripts.deploy="gh-pages -d build"

# Build the React app
echo "🔨 Building React application..."
npm run build

# Deploy to GitHub Pages
echo "🚀 Deploying to GitHub Pages..."
npm run deploy

# Get repository URL
REPO_URL=$(git remote get-url origin)
USERNAME=$(echo $REPO_URL | sed 's/.*github.com[:/]\([^/]*\).*/\1/')
REPO_NAME=$(echo $REPO_URL | sed 's/.*github.com[:/][^/]*\/\([^.]*\).*/\1/')

echo "✅ Application deployed!"
echo "🌐 Access your app at: https://$USERNAME.github.io/$REPO_NAME"
echo ""
echo "🎯 GitHub Pages Deployment Summary:"
echo "  • Application: https://$USERNAME.github.io/$REPO_NAME"
echo "  • Cost: $0 (completely free)"
echo "  • Setup time: 3 minutes"
echo "  • Auto-deploys on git push"
echo "  • Custom domain support"
echo ""
echo "📊 GitHub Repository:"
echo "  $REPO_URL"
echo ""
echo "🔧 To update deployment:"
echo "  git add ."
echo "  git commit -m 'Update deployment'"
echo "  git push origin main"
echo "  npm run deploy"
echo ""
echo "💡 Note: This deploys the React frontend only."
echo "   For full Kubernetes + Vault demo, use GCP free tier."
