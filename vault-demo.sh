#!/bin/bash

# Vault Demo Script for Project 4
# Demonstrates HashiCorp Vault secret management

echo "🔐 HashiCorp Vault Demo - Project 4: Kubernetes Security"
echo "=================================================="
echo ""

# Set Vault environment
export VAULT_ADDR="http://localhost:8200"
export VAULT_TOKEN="root"

echo "📊 Vault Status:"
docker exec -e VAULT_ADDR="http://127.0.0.1:8200" -e VAULT_TOKEN="root" vault-demo vault status
echo ""

echo "🔑 Available Secrets:"
echo "---------------------"
docker exec -e VAULT_ADDR="http://127.0.0.1:8200" -e VAULT_TOKEN="root" vault-demo vault kv list secret/
echo ""

echo "📱 App Configuration Secrets:"
echo "-----------------------------"
docker exec -e VAULT_ADDR="http://127.0.0.1:8200" -e VAULT_TOKEN="root" vault-demo vault kv get secret/david-vizena/app
echo ""

echo "🔒 Security Configuration Secrets:"
echo "----------------------------------"
docker exec -e VAULT_ADDR="http://127.0.0.1:8200" -e VAULT_TOKEN="root" vault-demo vault kv get secret/david-vizena/security
echo ""

echo "🌐 Vault UI Access:"
echo "-------------------"
echo "Open your browser and go to: http://localhost:8200"
echo "Root Token: root"
echo ""

echo "🎯 Demo Features:"
echo "-----------------"
echo "✅ HashiCorp Vault running in Docker"
echo "✅ KV secrets engine enabled"
echo "✅ Sample secrets created"
echo "✅ Web UI accessible"
echo "✅ Ready for live demonstration"
echo ""

echo "🚀 Perfect for showcasing Kubernetes security skills to employers!"
