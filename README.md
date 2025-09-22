# David Vizena - Kubernetes Security Portfolio Project

**Project 4: Kubernetes Security with HashiCorp Vault**

A comprehensive demonstration of Kubernetes security best practices, featuring HashiCorp Vault for secrets management, RBAC, and secure application deployment.

## 🔐 Security Features

- **HashiCorp Vault**: Enterprise-grade secrets management
- **Kubernetes RBAC**: Role-based access control and service accounts
- **Encrypted Secrets**: Secure storage and transmission of sensitive data
- **Network Policies**: Micro-segmentation and traffic control
- **Audit Logging**: Comprehensive security event tracking
- **React Frontend**: Modern, responsive UI demonstrating secret retrieval
- **Docker Containerization**: Multi-stage build for optimized production image
- **Cloud Deployment**: Ready for DigitalOcean, GCP, and AWS

## 🌐 Live Demo (FREE Options)

**🆓 FREE Deployment Options**:
- **Railway**: [5-Minute Setup](RAILWAY_DEPLOYMENT.md) (100% FREE - Recommended)
- **Vercel**: [React Frontend](cloud/vercel-deploy.sh) (Completely free)
- **GitHub Pages**: [Static Hosting](cloud/github-pages-deploy.sh) (Completely free)
- **Google Cloud**: [Free Deploy Guide](cloud/free-deploy.md#option-1-google-cloud-platform-recommended) ($300 free credits)

**Demo Features**:
- **Live Application**: React app with Vault integration
- **Vault UI**: HashiCorp Vault web interface (GCP only)
- **Secret Management**: Real-time secret retrieval and display
- **Security Policies**: RBAC and network policies in action
- **Kubernetes Dashboard**: Pod status and resource monitoring (GCP only)

## 🛠️ Tech Stack

- **Frontend**: React 18, Tailwind CSS
- **Containerization**: Docker, Nginx
- **Orchestration**: Kubernetes
- **Secrets Management**: HashiCorp Vault 1.15.2
- **Security**: RBAC, Network Policies, Service Accounts
- **Networking**: LoadBalancer Service, Ingress
- **Cloud Platforms**: DigitalOcean, GCP, AWS

## 📦 Quick Start

### Prerequisites

- Node.js 18+
- Docker
- Kubernetes cluster (local or cloud)
- kubectl configured

### Local Development

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Start development server**:
   ```bash
   npm start
   ```

3. **Build for production**:
   ```bash
   npm run build
   ```

### Docker Deployment

1. **Build Docker image**:
   ```bash
   docker build -t davidvizena/hello-world:latest .
   ```

2. **Run locally**:
   ```bash
   docker run -p 8080:8080 davidvizena/hello-world:latest
   ```

### Kubernetes Deployment

1. **Start minikube cluster**:
   ```bash
   minikube start
   ```

2. **Deploy to Kubernetes**:
   ```bash
   ./deploy.sh
   ```

3. **Or deploy manually**:
   ```bash
   kubectl apply -f k8s/
   ```

4. **Get service URL**:
   ```bash
   minikube service david-vizena-service -n david-vizena
   ```

## 🌐 Free Hosting Options

### Option 1: Railway
- Connect your GitHub repo to Railway
- Automatic deployments on push
- Free tier available
- Custom domain support

### Option 2: Render
- Connect GitHub repo
- Free tier with custom domains
- Automatic SSL certificates

### Option 3: Vercel
- Perfect for React apps
- Free tier available
- Automatic deployments

## 📁 Project Structure

```
├── src/
│   ├── App.js          # Main React component
│   ├── index.js        # React entry point
│   └── index.css       # Tailwind CSS imports
├── public/
│   └── index.html      # HTML template
├── k8s/
│   ├── namespace.yaml  # Kubernetes namespace
│   ├── deployment.yaml # App deployment
│   ├── service.yaml    # LoadBalancer service
│   └── network-policy.yaml # Network policies
├── Dockerfile          # Multi-stage Docker build
├── nginx.conf          # Nginx configuration
└── deploy.sh           # Deployment script
```

## 🔧 Configuration

### Environment Variables
- `PORT`: Application port (default: 8080)

### Kubernetes Resources
- **CPU**: 50m request, 100m limit
- **Memory**: 64Mi request, 128Mi limit
- **Replicas**: 2 (for high availability)


## 🚀 Multi-Cloud Portfolio Series

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

### **Project 4: Security & Secrets Management** (Google Cloud) ⭐
- ✅ HashiCorp Vault Integration
- ✅ GCP GKE Deployment
- ✅ RBAC & Access Control
- ✅ Encryption & Data Protection
- ✅ Multi-Cloud Security Expertise

**🎯 Strategic Approach**: Each project uses different cloud platforms to demonstrate **cloud-agnostic** SRE skills that employers value.

## 📝 License

MIT License - feel free to use this as a template for your own portfolio projects!

---

**Built with ❤️ by David Vizena**
# Test update
