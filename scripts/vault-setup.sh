#!/bin/bash

# Vault Setup Script for Kubernetes Security Demo
# This script configures Vault with Kubernetes auth and creates sample secrets

set -e

echo "🔐 Setting up HashiCorp Vault for Kubernetes Security Demo..."

# Wait for Vault to be ready
echo "⏳ Waiting for Vault to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/vault -n david-vizena

# Port forward to Vault
echo "🔗 Setting up port forward to Vault..."
kubectl port-forward -n david-vizena svc/vault 8200:8200 &
VAULT_PID=$!

# Wait for port forward to be ready
sleep 5

# Set Vault environment
export VAULT_ADDR="http://localhost:8200"
export VAULT_TOKEN="root"

echo "🚀 Configuring Vault..."

# Enable Kubernetes auth method
echo "📋 Enabling Kubernetes auth method..."
vault auth enable kubernetes

# Configure Kubernetes auth
echo "⚙️ Configuring Kubernetes auth..."
vault write auth/kubernetes/config \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt

# Create a policy for our app
echo "📝 Creating Vault policy..."
vault policy write david-vizena-policy - <<EOF
# Allow read access to secrets
path "secret/data/david-vizena/*" {
  capabilities = ["read"]
}

# Allow read access to app config
path "secret/data/app-config/*" {
  capabilities = ["read"]
}
EOF

# Create a role for our app
echo "🎭 Creating Vault role..."
vault write auth/kubernetes/role/david-vizena-app \
    bound_service_account_names=david-vizena-app \
    bound_service_account_namespaces=david-vizena \
    policies=david-vizena-policy \
    ttl=1h

# Enable KV secrets engine
echo "🗄️ Enabling KV secrets engine..."
vault secrets enable -path=secret kv-v2

# Create sample secrets
echo "🔑 Creating sample secrets..."

# App configuration secrets
vault kv put secret/app-config/database \
    host="postgres.example.com" \
    port="5432" \
    username="app_user" \
    password="super_secure_password_123"

vault kv put secret/app-config/api \
    api_key="sk-1234567890abcdef" \
    api_url="https://api.example.com" \
    rate_limit="1000"

# Application secrets
vault kv put secret/david-vizena/app \
    app_name="David Vizena Portfolio" \
    version="4.0.0" \
    environment="production" \
    debug="false"

vault kv put secret/david-vizena/security \
    jwt_secret="jwt_super_secret_key_2024" \
    encryption_key="encryption_key_32_chars_long" \
    session_timeout="3600"

# Display created secrets
echo "✅ Vault setup complete! Created secrets:"
echo ""
echo "📊 Available secrets:"
vault kv list secret/app-config/
vault kv list secret/david-vizena/
echo ""
echo "🔐 Vault is ready for Kubernetes security demo!"
echo "🌐 Vault UI available at: http://localhost:8200"
echo "🔑 Root token: root"
echo ""
echo "To test secret retrieval:"
echo "vault kv get secret/david-vizena/app"
echo ""

# Keep port forward running
echo "🔄 Port forward is running (PID: $VAULT_PID)"
echo "Press Ctrl+C to stop the port forward"
wait $VAULT_PID
