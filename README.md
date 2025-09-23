# 🔐 Kubernetes Security with HashiCorp Vault

**Project 4: Enterprise Secret Management & Security**

A comprehensive demonstration of Kubernetes security best practices, featuring HashiCorp Vault for secrets management, RBAC, and secure application deployment.

## 🌐 Live Demo

**🔗 [View Live Demo](https://k8s-security-production.up.railway.app)**

Interactive demonstration showcasing:
- ✅ **Secret Management**: HashiCorp Vault integration
- ✅ **Security Features**: Encryption, access control, audit logging
- ✅ **Real-time Demo**: Click "Refresh Secrets" and "Rotate Security Keys"
- ✅ **Professional UI**: Modern React interface with Tailwind CSS

## 🔐 Security Features

- **HashiCorp Vault**: Enterprise-grade secrets management
- **Kubernetes RBAC**: Role-based access control and service accounts
- **Encrypted Secrets**: Secure storage and transmission of sensitive data
- **Network Policies**: Micro-segmentation and traffic control
- **Audit Logging**: Comprehensive security event tracking
- **Secret Rotation**: Dynamic key rotation without downtime

## 🛠️ Tech Stack

- **Frontend**: React 18, Tailwind CSS
- **Containerization**: Docker, Nginx
- **Orchestration**: Kubernetes
- **Secrets Management**: HashiCorp Vault
- **Security**: RBAC, Network Policies, Service Accounts
- **Deployment**: Railway (Cloud hosting)

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- Docker
- Kubernetes cluster (optional)

### Local Development
```bash
# Install dependencies
npm install

# Start development server
npm start

# Build for production
npm run build
```

### Docker Deployment
```bash
# Build Docker image
docker build -t k8s-security .

# Run locally
docker run -p 8080:8080 k8s-security
```

### Kubernetes Deployment
```bash
# Deploy to Kubernetes
kubectl apply -f k8s/

# Get service URL
kubectl get service k8s-security-service -n k8s-security
```

## 📁 Project Structure

```
├── src/
│   ├── App.js              # Main React component
│   ├── components/
│   │   └── LiveVaultDemo.js # Interactive Vault demo
│   ├── index.js            # React entry point
│   └── index.css           # Tailwind CSS imports
├── k8s/
│   ├── namespace.yaml      # Kubernetes namespace
│   ├── deployment.yaml     # App deployment
│   ├── service.yaml        # LoadBalancer service
│   ├── network-policy.yaml # Network policies
│   └── vault-deployment.yaml # Vault deployment
├── public/
│   └── index.html          # HTML template
├── Dockerfile              # Multi-stage Docker build
├── nginx.conf              # Nginx configuration
├── railway.json            # Railway deployment config
└── deploy.sh               # Deployment script
```

## 🎯 Portfolio Series

This is **Project 4** of a 4-project portfolio series demonstrating **cross-platform SRE expertise**:

### **Project 1: Foundation** (Local Kubernetes)
- ✅ React Frontend + Tailwind CSS
- ✅ Docker Containerization
- ✅ Kubernetes Orchestration
- ✅ Network Policies & Security

### **Project 2: Monitoring & Observability** (AWS)
- ✅ Grafana Dashboards
- ✅ Prometheus Metrics
- ✅ AWS EKS Integration
- ✅ CloudWatch & Monitoring

### **Project 3: CI/CD & GitOps** (GitHub Actions)
- ✅ GitHub Actions Pipelines
- ✅ ArgoCD Deployment
- ✅ Automated Testing
- ✅ GitOps Workflows

### **Project 4: Security & Secrets Management** (Railway) ⭐
- ✅ HashiCorp Vault Integration
- ✅ Interactive Security Demo
- ✅ RBAC & Access Control
- ✅ Encryption & Data Protection
- ✅ Multi-Cloud Security Expertise

**🎯 Strategic Approach**: Each project uses different cloud platforms to demonstrate **cloud-agnostic** SRE skills that employers value.

## 🔧 Configuration

### Environment Variables
- `NODE_ENV`: Application environment (development/production)
- `PORT`: Application port (default: 8080)

### Kubernetes Resources
- **CPU**: 50m request, 100m limit
- **Memory**: 64Mi request, 128Mi limit
- **Replicas**: 2 (for high availability)

## 📊 Demo Features

### **Interactive Vault Simulation**
- **Secret Display**: Shows app config, security keys, database credentials
- **Secret Rotation**: Demonstrates key rotation without downtime
- **Access Control**: Simulates RBAC and permission management
- **Audit Logging**: Shows security event tracking

### **Real-World Use Cases**
- **Database Credentials**: Secure connection strings
- **API Keys**: Third-party service authentication
- **TLS Certificates**: SSL/TLS certificate management
- **Application Secrets**: JWT signing keys, encryption keys

## 🛡️ Security Best Practices

- **Encryption at Rest**: All secrets encrypted in storage
- **Access Control**: Role-based permissions (RBAC)
- **Audit Logging**: Every access logged and monitored
- **Secret Rotation**: Keys rotated without downtime
- **Dynamic Secrets**: Short-lived credentials for databases
- **Kubernetes Integration**: Automatic service account authentication

## 📝 License

MIT License - feel free to use this as a template for your own portfolio projects!

---

**Built with ❤️ by David Vizena**

*Demonstrating modern DevOps, security, and cloud-native practices for enterprise environments.*