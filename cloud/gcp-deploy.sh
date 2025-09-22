#!/bin/bash

# Google Cloud Platform (GKE) Deployment Script
# Project 4: Kubernetes Security with HashiCorp Vault

set -e

echo "☁️ Deploying to Google Cloud Platform (GKE)..."

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "❌ gcloud is not installed. Please install it first:"
    echo "   https://cloud.google.com/sdk/docs/install"
    exit 1
fi

# Check if kubectl is configured for GKE
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ kubectl is not configured for GKE cluster"
    echo "Please run: gcloud container clusters get-credentials <cluster-name> --zone <zone>"
    exit 1
fi

# Build and push to Google Container Registry
echo "🔨 Building Docker image..."
docker build -t gcr.io/$(gcloud config get-value project)/k8s-security:latest .

echo "📦 Pushing to Google Container Registry..."
docker push gcr.io/$(gcloud config get-value project)/k8s-security:latest

# Update deployment to use GCR image
echo "📋 Updating deployment for GCP..."
sed 's|imagePullPolicy: Never|imagePullPolicy: Always|g' k8s/deployment.yaml > k8s/deployment-gcp.yaml
sed -i '' "s|davidvizena/hello-world:latest|gcr.io/$(gcloud config get-value project)/k8s-security:latest|g" k8s/deployment-gcp.yaml

# Apply Kubernetes manifests
echo "🚀 Deploying to GKE..."
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/vault-deployment.yaml
kubectl apply -f k8s/deployment-gcp.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/network-policy.yaml

# Wait for deployments
echo "⏳ Waiting for deployments to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/vault -n david-vizena
kubectl wait --for=condition=available --timeout=300s deployment/david-vizena-app -n david-vizena

# Get external IP
echo "🌐 Getting external IP..."
EXTERNAL_IP=$(kubectl get service david-vizena-service -n david-vizena -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "✅ Application deployed!"
echo "🌐 Access your app at: http://$EXTERNAL_IP"

# Setup Vault
echo "🔧 Setting up Vault..."
kubectl port-forward -n david-vizena svc/vault 8200:8200 &
VAULT_PID=$!
sleep 5

export VAULT_ADDR="http://localhost:8200"
export VAULT_TOKEN="root"

# Enable KV secrets engine
vault secrets enable -path=secret kv-v2

# Create sample secrets
vault kv put secret/app-config/database \
    host="postgres.example.com" \
    port="5432" \
    username="app_user" \
    password="super_secure_password_123"

vault kv put secret/david-vizena/app \
    app_name="David Vizena Portfolio" \
    version="4.0.0" \
    environment="production"

echo "✅ Vault configured with sample secrets!"

# Cleanup
kill $VAULT_PID 2>/dev/null || true
rm -f k8s/deployment-gcp.yaml

echo ""
echo "🎯 Deployment Summary:"
echo "  • Application: http://$EXTERNAL_IP"
echo "  • Vault UI: http://$EXTERNAL_IP:8200"
echo "  • Root token: root"
echo ""
echo "📊 Check status with:"
echo "  kubectl get pods -n david-vizena"
echo "  kubectl get services -n david-vizena"
