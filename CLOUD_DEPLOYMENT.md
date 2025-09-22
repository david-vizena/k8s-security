# 🌐 Cloud Deployment Guide

This guide shows how to deploy Project 4 (Kubernetes Security with HashiCorp Vault) to various cloud platforms for online access.

## 🚀 Quick Start Options

### Option 1: DigitalOcean (Recommended - Most Cost-Effective)
- **Cost**: ~$12-24/month
- **Setup Time**: 15 minutes
- **Perfect for**: Portfolio demonstrations

### Option 2: Google Cloud Platform (GKE)
- **Cost**: ~$25-50/month (with free credits)
- **Setup Time**: 20 minutes
- **Perfect for**: Enterprise demonstrations

### Option 3: AWS EKS
- **Cost**: ~$30-60/month
- **Setup Time**: 25 minutes
- **Perfect for**: AWS-focused roles

---

## 🌊 DigitalOcean Deployment (Recommended)

### Prerequisites
1. DigitalOcean account
2. Docker Hub account
3. `doctl` CLI installed

### Setup Steps

1. **Install doctl**:
   ```bash
   brew install doctl
   doctl auth init
   ```

2. **Create Kubernetes Cluster**:
   ```bash
   doctl kubernetes cluster create david-vizena-k8s \
     --region nyc1 \
     --version 1.28 \
     --node-pool "name=worker-pool;size=s-2vcpu-2gb;count=2"
   ```

3. **Configure kubectl**:
   ```bash
   doctl kubernetes cluster kubeconfig save david-vizena-k8s
   ```

4. **Deploy Application**:
   ```bash
   chmod +x cloud/digitalocean-deploy.sh
   ./cloud/digitalocean-deploy.sh
   ```

5. **Access Your Application**:
   - Get external IP: `kubectl get service david-vizena-service -n david-vizena`
   - Visit: `http://<EXTERNAL_IP>`

---

## ☁️ Google Cloud Platform (GKE) Deployment

### Prerequisites
1. Google Cloud account with billing enabled
2. `gcloud` CLI installed
3. Docker installed

### Setup Steps

1. **Install gcloud**:
   ```bash
   # macOS
   brew install google-cloud-sdk
   
   # Or download from: https://cloud.google.com/sdk/docs/install
   ```

2. **Authenticate and Set Project**:
   ```bash
   gcloud auth login
   gcloud config set project YOUR_PROJECT_ID
   ```

3. **Create GKE Cluster**:
   ```bash
   gcloud container clusters create david-vizena-k8s \
     --zone us-central1-a \
     --num-nodes 2 \
     --machine-type e2-medium
   ```

4. **Configure kubectl**:
   ```bash
   gcloud container clusters get-credentials david-vizena-k8s --zone us-central1-a
   ```

5. **Deploy Application**:
   ```bash
   chmod +x cloud/gcp-deploy.sh
   ./cloud/gcp-deploy.sh
   ```

6. **Access Your Application**:
   - Get external IP: `kubectl get service david-vizena-service -n david-vizena`
   - Visit: `http://<EXTERNAL_IP>`

---

## 🔧 Cost Optimization Tips

### DigitalOcean
- Use `s-1vcpu-1gb` nodes for development (~$6/month)
- Scale down when not demonstrating
- Use DigitalOcean Spaces for static assets

### Google Cloud
- Use preemptible instances (up to 80% savings)
- Set up billing alerts
- Use free tier credits ($300 for new accounts)

### AWS
- Use Spot instances for non-production
- Set up cost monitoring
- Use AWS Free Tier when possible

---

## 🎯 Portfolio Presentation Tips

### For Interviews
1. **Live Demo**: Show the running application
2. **Vault UI**: Demonstrate secret management
3. **Kubernetes Dashboard**: Show pod status and logs
4. **Security Features**: Explain RBAC and policies

### For Portfolio Website
1. **Screenshots**: Include UI screenshots
2. **Architecture Diagram**: Show the complete setup
3. **Live Links**: Provide access URLs
4. **Documentation**: Link to this guide

---

## 🔐 Security Considerations

### Production Readiness
- Use proper TLS certificates
- Implement network policies
- Set up monitoring and alerting
- Use proper secret rotation

### Demo Environment
- Root token is for demo purposes only
- Vault is in dev mode (not production-ready)
- Use strong passwords in production

---

## 📊 Monitoring Your Deployment

### Check Application Status
```bash
kubectl get pods -n david-vizena
kubectl get services -n david-vizena
kubectl logs -f deployment/david-vizena-app -n david-vizena
```

### Check Vault Status
```bash
kubectl logs -f deployment/vault -n david-vizena
kubectl port-forward -n david-vizena svc/vault 8200:8200
# Visit http://localhost:8200
```

### Resource Usage
```bash
kubectl top pods -n david-vizena
kubectl top nodes
```

---

## 🆘 Troubleshooting

### Common Issues

1. **Image Pull Errors**:
   - Ensure Docker image is pushed to registry
   - Check image pull secrets

2. **Vault Connection Issues**:
   - Verify Vault pod is running
   - Check service endpoints

3. **External IP Not Assigned**:
   - Wait for LoadBalancer provisioning
   - Check cloud provider quotas

### Getting Help
- Check pod logs: `kubectl logs <pod-name> -n david-vizena`
- Describe resources: `kubectl describe <resource> <name> -n david-vizena`
- Check events: `kubectl get events -n david-vizena`

---

## 🎉 Success!

Once deployed, you'll have:
- ✅ A live Kubernetes application
- ✅ HashiCorp Vault for secrets management
- ✅ RBAC and security policies
- ✅ Professional portfolio demonstration
- ✅ Real-world SRE experience showcase

**Perfect for impressing potential employers!** 🚀
