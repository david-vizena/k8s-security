# 🚀 Quick GCP Deployment Guide

**Deploy Project 4 to Google Cloud Platform in 15 minutes**

## 🎯 Why GCP for Project 4?

- **Complements AWS Project 2** - Shows multi-cloud expertise
- **$300 free credits** - No cost for months
- **Superior Kubernetes** - GKE is industry-leading
- **Enterprise security** - Perfect for Vault integration
- **Employer appeal** - Demonstrates platform versatility

---

## ⚡ 15-Minute Setup

### Step 1: Google Cloud Setup (5 minutes)
```bash
# 1. Go to Google Cloud Console
# https://console.cloud.google.com

# 2. Create new project (or use existing)
# 3. Enable billing (won't charge with free credits)

# 4. Install gcloud CLI
brew install google-cloud-sdk

# 5. Authenticate
gcloud auth login
gcloud config set project YOUR_PROJECT_ID
```

### Step 2: Create GKE Cluster (5 minutes)
```bash
# Create free-tier cluster
gcloud container clusters create david-vizena-k8s \
  --zone us-central1-a \
  --num-nodes 1 \
  --machine-type e2-micro \
  --disk-size 10GB \
  --disk-type pd-standard \
  --enable-autoscaling \
  --min-nodes 0 \
  --max-nodes 1 \
  --preemptible

# Configure kubectl
gcloud container clusters get-credentials david-vizena-k8s --zone us-central1-a
```

### Step 3: Deploy Application (5 minutes)
```bash
# Run the deployment script
chmod +x cloud/gcp-free-deploy.sh
./cloud/gcp-free-deploy.sh
```

**That's it!** 🎉

---

## 🌐 Access Your Demo

After deployment, you'll get:
- **Application URL**: `http://<EXTERNAL_IP>`
- **Vault UI**: `http://<EXTERNAL_IP>:8200`
- **Root token**: `root`

---

## 💰 Cost Breakdown

| Resource | Free Tier | Your Usage | Cost |
|----------|-----------|------------|------|
| GKE Cluster | 1 cluster | 1 cluster | $0 |
| e2-micro nodes | 1 node | 1 node | $0 |
| Load Balancer | 1 | 1 | ~$18/month |
| Container Registry | 0.5GB | <0.5GB | $0 |
| **Total** | | | **~$18/month** |

**With $300 free credits = 16+ months free!**

---

## 🎯 Portfolio Talking Points

### **"Why GCP for this project?"**
> "I chose GCP for Project 4 because it has superior Kubernetes integration with GKE, and I wanted to demonstrate multi-cloud expertise. My Project 2 uses AWS for monitoring, so this shows I can work with different cloud providers and choose the right tool for each job."

### **"How does this complement your AWS project?"**
> "Project 2 focuses on AWS monitoring with Grafana and Prometheus, while Project 4 showcases GCP security with HashiCorp Vault. This demonstrates I'm not vendor-locked and can adapt to any cloud environment."

### **"What's your cloud strategy?"**
> "I'm cloud-agnostic but platform-aware. I use AWS for monitoring because of its mature ecosystem, GCP for Kubernetes because of GKE's superior implementation, and choose the right platform based on the specific requirements."

---

## 🔧 Management Commands

### Check Status
```bash
kubectl get pods -n david-vizena
kubectl get services -n david-vizena
kubectl top pods -n david-vizena
```

### Access Vault
```bash
kubectl port-forward -n david-vizena svc/vault 8200:8200
# Visit http://localhost:8200
```

### View Logs
```bash
kubectl logs -f deployment/david-vizena-app -n david-vizena
kubectl logs -f deployment/vault -n david-vizena
```

### Scale Down (Save Money)
```bash
kubectl scale deployment david-vizena-app --replicas=0 -n david-vizena
kubectl scale deployment vault --replicas=0 -n david-vizena
```

### Scale Up (Before Demo)
```bash
kubectl scale deployment david-vizena-app --replicas=1 -n david-vizena
kubectl scale deployment vault --replicas=1 -n david-vizena
```

---

## 🎉 Success!

You now have:
- ✅ **Multi-cloud portfolio** (AWS + GCP)
- ✅ **Live Kubernetes security demo**
- ✅ **HashiCorp Vault integration**
- ✅ **Professional presentation**
- ✅ **$0 cost** (using free credits)

**Perfect for impressing employers with your cloud versatility!** 🚀
