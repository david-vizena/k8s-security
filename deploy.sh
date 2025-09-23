#!/bin/bash

# Kubernetes Security Project - Deployment Script
# Project 4: HashiCorp Vault Integration

set -e

echo "🔐 Deploying Kubernetes Security Project with HashiCorp Vault..."

# Build Docker image
echo "📦 Building Docker image..."
docker build -t k8s-security:latest .

# Deploy to Kubernetes
echo "☸️  Deploying to Kubernetes..."
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/network-policy.yaml
kubectl apply -f k8s/vault-deployment.yaml

# Wait for deployment to be ready
echo "⏳ Waiting for deployment to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/k8s-security-app -n k8s-security

# Get service info
echo "🌐 Getting service information..."
kubectl get service k8s-security-service -n k8s-security

echo "✅ Deployment complete!"
echo "🔗 Your app should be accessible via the LoadBalancer external IP"
echo "🔐 Vault UI available at: http://localhost:8200"