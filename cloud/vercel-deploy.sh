#!/bin/bash

# Vercel FREE Deployment Script
# Deploy React frontend only (completely free)

set -e

echo "▲ Deploying to Vercel (FREE - React frontend only)..."

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Installing Vercel CLI..."
    npm install -g vercel
fi

# Check if user is logged in
if ! vercel whoami &> /dev/null; then
    echo "🔐 Please login to Vercel:"
    vercel login
fi

# Build the React app
echo "🔨 Building React application..."
npm run build

# Deploy to Vercel
echo "🚀 Deploying to Vercel..."
vercel --prod

# Get deployment URL
echo "🌐 Getting deployment URL..."
DEPLOYMENT_URL=$(vercel ls --json | jq -r '.[0].url')

echo "✅ Application deployed!"
echo "🌐 Access your app at: https://$DEPLOYMENT_URL"
echo ""
echo "🎯 Vercel Deployment Summary:"
echo "  • Application: https://$DEPLOYMENT_URL"
echo "  • Cost: $0 (completely free)"
echo "  • Setup time: 2 minutes"
echo "  • Auto-deploys on git push"
echo "  • Global CDN included"
echo ""
echo "📊 Vercel Dashboard:"
echo "  https://vercel.com/dashboard"
echo ""
echo "🔧 To update deployment:"
echo "  git push origin main"
echo "  (Vercel auto-deploys)"
echo ""
echo "💡 Note: This deploys the React frontend only."
echo "   For full Kubernetes + Vault demo, use GCP free tier."
