#!/bin/bash

# Google Cloud Platform FREE Deployment Script
# Uses free tier and $300 credits

set -e

echo "🆓 Deploying to Google Cloud Platform (FREE TIER)..."

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "❌ gcloud is not installed. Please install it first:"
    echo "   brew install google-cloud-sdk"
    exit 1
fi

# Check if user is authenticated
if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q .; then
    echo "🔐 Please authenticate with Google Cloud:"
    gcloud auth login
fi

# Get project ID
PROJECT_ID=$(gcloud config get-value project 2>/dev/null)
if [ -z "$PROJECT_ID" ]; then
    echo "❌ No project set. Please set a project:"
    echo "   gcloud config set project YOUR_PROJECT_ID"
    exit 1
fi

echo "📋 Using project: $PROJECT_ID"

# Check if cluster exists, create if not
if ! gcloud container clusters describe david-vizena-free --zone=us-central1-a &>/dev/null; then
    echo "🏗️ Creating free GKE cluster..."
    gcloud container clusters create david-vizena-free \
        --zone us-central1-a \
        --num-nodes 1 \
        --machine-type e2-micro \
        --disk-size 10GB \
        --disk-type pd-standard \
        --enable-autoscaling \
        --min-nodes 0 \
        --max-nodes 1 \
        --preemptible
else
    echo "✅ Cluster already exists"
fi

# Configure kubectl
echo "⚙️ Configuring kubectl..."
gcloud container clusters get-credentials david-vizena-free --zone us-central1-a

# Build and push to Google Container Registry
echo "🔨 Building Docker image..."
docker build -t gcr.io/$PROJECT_ID/k8s-security:latest .

echo "📦 Pushing to Google Container Registry..."
docker push gcr.io/$PROJECT_ID/k8s-security:latest

# Update deployment for GCP
echo "📋 Creating cloud deployment manifest..."
cat > k8s/deployment-free.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: david-vizena-app
  namespace: david-vizena
  labels:
    app: david-vizena-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: david-vizena-app
  template:
    metadata:
      labels:
        app: david-vizena-app
    spec:
      serviceAccountName: david-vizena-app
      containers:
      - name: david-vizena-app
        image: gcr.io/$PROJECT_ID/k8s-security:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
        env:
        - name: VAULT_ADDR
          value: "http://vault:8200"
        - name: VAULT_ROLE
          value: "david-vizena-app"
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
        livenessProbe:
          httpGet:
            path: /
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: david-vizena-app
  namespace: david-vizena
  labels:
    app: david-vizena-app
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: david-vizena
  name: david-vizena-app-role
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["get", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: david-vizena-app-rolebinding
  namespace: david-vizena
subjects:
- kind: ServiceAccount
  name: david-vizena-app
  namespace: david-vizena
roleRef:
  kind: Role
  name: david-vizena-app-role
  apiGroup: rbac.authorization.k8s.io
EOF

# Apply Kubernetes manifests
echo "🚀 Deploying to GKE..."
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/vault-deployment.yaml
kubectl apply -f k8s/deployment-free.yaml
kubectl apply -f k8s/service.yaml

# Wait for deployments
echo "⏳ Waiting for deployments to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/vault -n david-vizena
kubectl wait --for=condition=available --timeout=300s deployment/david-vizena-app -n david-vizena

# Get external IP
echo "🌐 Getting external IP..."
EXTERNAL_IP=$(kubectl get service david-vizena-service -n david-vizena -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
if [ -z "$EXTERNAL_IP" ]; then
    echo "⏳ Waiting for external IP assignment..."
    sleep 30
    EXTERNAL_IP=$(kubectl get service david-vizena-service -n david-vizena -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
fi

echo "✅ Application deployed!"
echo "🌐 Access your app at: http://$EXTERNAL_IP"

# Setup Vault with sample data
echo "🔧 Setting up Vault with sample secrets..."
kubectl port-forward -n david-vizena svc/vault 8200:8200 &
VAULT_PID=$!
sleep 10

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

vault kv put secret/david-vizena/security \
    jwt_secret="jwt_super_secret_key_2024" \
    encryption_key="encryption_key_32_chars_long" \
    session_timeout="3600"

echo "✅ Vault configured with sample secrets!"

# Cleanup
kill $VAULT_PID 2>/dev/null || true
rm -f k8s/deployment-free.yaml

echo ""
echo "🎯 FREE Deployment Summary:"
echo "  • Application: http://$EXTERNAL_IP"
echo "  • Vault UI: http://$EXTERNAL_IP:8200"
echo "  • Root token: root"
echo "  • Cost: $0 (using free tier)"
echo ""
echo "📊 Check status with:"
echo "  kubectl get pods -n david-vizena"
echo "  kubectl get services -n david-vizena"
echo ""
echo "💰 Cost Optimization:"
echo "  • Using e2-micro instances (free tier)"
echo "  • Single node cluster"
echo "  • Preemptible instances"
echo "  • Auto-scaling enabled"
