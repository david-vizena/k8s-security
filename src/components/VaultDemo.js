import React, { useState, useEffect } from 'react';

const VaultDemo = () => {
  const [secrets, setSecrets] = useState({});
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [vaultStatus, setVaultStatus] = useState('disconnected');

  const fetchSecrets = async () => {
    setLoading(true);
    setError(null);
    
    try {
      // In a real application, this would be done server-side
      // For demo purposes, we'll simulate the API call
      const response = await fetch('/api/vault/secrets');
      
      if (!response.ok) {
        throw new Error('Failed to fetch secrets');
      }
      
      const data = await response.json();
      setSecrets(data);
      setVaultStatus('connected');
    } catch (err) {
      setError(err.message);
      setVaultStatus('error');
      // For demo purposes, show mock data
      setSecrets({
        app: {
          app_name: "David Vizena Portfolio",
          version: "4.0.0",
          environment: "production"
        },
        security: {
          jwt_secret: "jwt_super_secret_key_2024",
          encryption_key: "encryption_key_32_chars_long",
          session_timeout: "3600"
        }
      });
      setVaultStatus('demo_mode');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchSecrets();
  }, []);

  const getStatusColor = () => {
    switch (vaultStatus) {
      case 'connected': return 'bg-green-100 text-green-800';
      case 'error': return 'bg-red-100 text-red-800';
      case 'demo_mode': return 'bg-yellow-100 text-yellow-800';
      default: return 'bg-gray-100 text-gray-800';
    }
  };

  const getStatusText = () => {
    switch (vaultStatus) {
      case 'connected': return 'Connected to Vault';
      case 'error': return 'Vault Connection Error';
      case 'demo_mode': return 'Demo Mode (Mock Data)';
      default: return 'Disconnected';
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-lg p-6 mb-8">
      <div className="flex items-center justify-between mb-6">
        <h2 className="text-2xl font-bold text-gray-800">
          🔐 Vault Secrets Management
        </h2>
        <div className={`px-3 py-1 rounded-full text-sm font-medium ${getStatusColor()}`}>
          {getStatusText()}
        </div>
      </div>

      <div className="mb-6">
        <p className="text-gray-600 mb-4">
          This demonstrates secure secret retrieval using HashiCorp Vault in Kubernetes.
          Secrets are encrypted at rest and in transit, with fine-grained access control.
        </p>
        
        <button
          onClick={fetchSecrets}
          disabled={loading}
          className="bg-blue-600 hover:bg-blue-700 disabled:bg-blue-300 text-white px-4 py-2 rounded-lg font-medium transition-colors"
        >
          {loading ? '🔄 Refreshing...' : '🔄 Refresh Secrets'}
        </button>
      </div>

      {error && (
        <div className="bg-red-50 border border-red-200 rounded-lg p-4 mb-6">
          <div className="flex">
            <div className="flex-shrink-0">
              <span className="text-red-400">⚠️</span>
            </div>
            <div className="ml-3">
              <h3 className="text-sm font-medium text-red-800">Connection Error</h3>
              <div className="mt-2 text-sm text-red-700">
                <p>{error}</p>
                <p className="mt-1">Showing demo data for demonstration purposes.</p>
              </div>
            </div>
          </div>
        </div>
      )}

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* App Configuration */}
        <div className="bg-gray-50 rounded-lg p-4">
          <h3 className="text-lg font-semibold text-gray-800 mb-3 flex items-center">
            📱 App Configuration
          </h3>
          <div className="space-y-2">
            {secrets.app ? (
              Object.entries(secrets.app).map(([key, value]) => (
                <div key={key} className="flex justify-between items-center">
                  <span className="text-sm font-medium text-gray-600 capitalize">
                    {key.replace('_', ' ')}:
                  </span>
                  <span className="text-sm text-gray-800 font-mono bg-white px-2 py-1 rounded">
                    {value}
                  </span>
                </div>
              ))
            ) : (
              <p className="text-gray-500 text-sm">No app configuration loaded</p>
            )}
          </div>
        </div>

        {/* Security Configuration */}
        <div className="bg-gray-50 rounded-lg p-4">
          <h3 className="text-lg font-semibold text-gray-800 mb-3 flex items-center">
            🔒 Security Configuration
          </h3>
          <div className="space-y-2">
            {secrets.security ? (
              Object.entries(secrets.security).map(([key, value]) => (
                <div key={key} className="flex justify-between items-center">
                  <span className="text-sm font-medium text-gray-600 capitalize">
                    {key.replace('_', ' ')}:
                  </span>
                  <span className="text-sm text-gray-800 font-mono bg-white px-2 py-1 rounded">
                    {key.includes('secret') || key.includes('key') ? '••••••••' : value}
                  </span>
                </div>
              ))
            ) : (
              <p className="text-gray-500 text-sm">No security configuration loaded</p>
            )}
          </div>
        </div>
      </div>

      <div className="mt-6 p-4 bg-blue-50 rounded-lg">
        <h4 className="text-sm font-semibold text-blue-800 mb-2">
          🛡️ Security Features Demonstrated:
        </h4>
        <ul className="text-sm text-blue-700 space-y-1">
          <li>• HashiCorp Vault integration for secret management</li>
          <li>• Kubernetes service account authentication</li>
          <li>• RBAC (Role-Based Access Control) policies</li>
          <li>• Encrypted secret storage and transmission</li>
          <li>• Fine-grained access control and audit logging</li>
        </ul>
      </div>
    </div>
  );
};

export default VaultDemo;
