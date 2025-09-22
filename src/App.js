import React from 'react';
import VaultDemo from './components/VaultDemo';
import LiveVaultDemo from './components/LiveVaultDemo';

function App() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 py-12">
      <div className="max-w-6xl mx-auto px-6">
        {/* Header Section */}
        <div className="text-center mb-12">
          <div className="bg-white rounded-2xl shadow-2xl p-12 transform hover:scale-105 transition-transform duration-300">
            <h1 className="text-6xl font-bold text-gray-800 mb-6">
              David Vizena
            </h1>
            <p className="text-xl text-gray-600 mb-8">
              Project 4: Kubernetes Security with HashiCorp Vault
            </p>
            <div className="flex justify-center space-x-4 flex-wrap gap-2">
              <div className="bg-blue-100 text-blue-800 px-4 py-2 rounded-full text-sm font-medium">
                React
              </div>
              <div className="bg-green-100 text-green-800 px-4 py-2 rounded-full text-sm font-medium">
                Tailwind CSS
              </div>
              <div className="bg-orange-100 text-orange-800 px-4 py-2 rounded-full text-sm font-medium">
                Docker
              </div>
              <div className="bg-purple-100 text-purple-800 px-4 py-2 rounded-full text-sm font-medium">
                Kubernetes
              </div>
              <div className="bg-red-100 text-red-800 px-4 py-2 rounded-full text-sm font-medium">
                HashiCorp Vault
              </div>
              <div className="bg-yellow-100 text-yellow-800 px-4 py-2 rounded-full text-sm font-medium">
                Security
              </div>
            </div>
          </div>
        </div>

        {/* Live Vault Demo Section */}
        <LiveVaultDemo />

        {/* Project Overview */}
        <div className="bg-white rounded-lg shadow-lg p-6">
          <h2 className="text-2xl font-bold text-gray-800 mb-4">
            🚀 Project 4: Kubernetes Security & Secrets Management
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <h3 className="text-lg font-semibold text-gray-800 mb-3">
                🔐 Security Features
              </h3>
              <ul className="text-gray-600 space-y-2">
                <li>• HashiCorp Vault for secret management</li>
                <li>• Kubernetes RBAC and service accounts</li>
                <li>• Encrypted secret storage and transmission</li>
                <li>• Fine-grained access control policies</li>
                <li>• Audit logging and compliance</li>
              </ul>
            </div>
            <div>
              <h3 className="text-lg font-semibold text-gray-800 mb-3">
                🛠️ Technical Stack
              </h3>
              <ul className="text-gray-600 space-y-2">
                <li>• React 18 with modern hooks</li>
                <li>• Tailwind CSS for styling</li>
                <li>• Docker multi-stage builds</li>
                <li>• Kubernetes orchestration</li>
                <li>• HashiCorp Vault 1.15.2</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
