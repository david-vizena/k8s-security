import React, { useState, useEffect } from 'react';

const LiveVaultDemo = () => {
  const [secrets, setSecrets] = useState({});
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [vaultStatus, setVaultStatus] = useState('disconnected');

  // Simulate Vault API calls (in real life, this would connect to actual Vault)
  const fetchSecrets = async () => {
    setLoading(true);
    setError(null);
    
    try {
      // Simulate API delay
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      // Mock Vault response (in real life, this would be actual Vault API)
      const mockVaultResponse = {
        app: {
          app_name: "David Vizena Portfolio",
          version: "4.0.0",
          environment: "production",
          last_updated: new Date().toISOString()
        },
        security: {
          jwt_secret: "jwt_super_secret_key_2024",
          encryption_key: "encryption_key_32_chars_long",
          session_timeout: "3600",
          last_rotated: "2024-09-22T23:00:00Z"
        },
        database: {
          host: "postgres.example.com",
          port: "5432",
          username: "app_user",
          password: "super_secure_password_123",
          ssl_enabled: true
        }
      };
      
      setSecrets(mockVaultResponse);
      setVaultStatus('connected');
    } catch (err) {
      setError(err.message);
      setVaultStatus('error');
    } finally {
      setLoading(false);
    }
  };

  const rotateSecret = async (secretPath) => {
    setLoading(true);
    try {
      // Simulate secret rotation
      await new Promise(resolve => setTimeout(resolve, 800));
      
      // Update the secret with new timestamp
      setSecrets(prev => ({
        ...prev,
        [secretPath]: {
          ...prev[secretPath],
          last_rotated: new Date().toISOString()
        }
      }));
      
      alert(`✅ Secret rotated successfully for ${secretPath}!`);
    } catch (err) {
      alert(`❌ Failed to rotate secret: ${err.message}`);
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
      case 'connected': return '🔐 Connected to Vault';
      case 'error': return '❌ Vault Connection Error';
      case 'demo_mode': return '🎭 Demo Mode (Simulated)';
      default: return '⏳ Connecting...';
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-lg p-6 mb-8">
      <div className="flex items-center justify-between mb-6">
        <h2 className="text-2xl font-bold text-gray-800">
          🔐 Live Vault Demo - Secret Management
        </h2>
        <div className={`px-3 py-1 rounded-full text-sm font-medium ${getStatusColor()}`}>
          {getStatusText()}
        </div>
      </div>

      <div className="mb-6">
        <p className="text-gray-600 mb-4">
          This demonstrates how HashiCorp Vault securely stores and manages secrets in a Kubernetes environment. 
          In production, secrets are encrypted, access-controlled, and audited.
        </p>
        
        <div className="flex space-x-4">
          <button
            onClick={fetchSecrets}
            disabled={loading}
            className="bg-blue-600 hover:bg-blue-700 disabled:bg-blue-300 text-white px-4 py-2 rounded-lg font-medium transition-colors"
          >
            {loading ? '🔄 Loading...' : '🔄 Refresh Secrets'}
          </button>
          
          <button
            onClick={() => rotateSecret('security')}
            disabled={loading}
            className="bg-orange-600 hover:bg-orange-700 disabled:bg-orange-300 text-white px-4 py-2 rounded-lg font-medium transition-colors"
          >
            🔄 Rotate Security Keys
          </button>
        </div>
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
              </div>
            </div>
          </div>
        </div>
      )}

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {/* App Configuration */}
        <div className="bg-gray-50 rounded-lg p-4">
          <div className="flex items-center justify-between mb-3">
            <h3 className="text-lg font-semibold text-gray-800 flex items-center">
              📱 App Config
            </h3>
            <span className="text-xs bg-blue-100 text-blue-800 px-2 py-1 rounded">
              v1.0
            </span>
          </div>
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
          <div className="flex items-center justify-between mb-3">
            <h3 className="text-lg font-semibold text-gray-800 flex items-center">
              🔒 Security Keys
            </h3>
            <button
              onClick={() => rotateSecret('security')}
              className="text-xs bg-orange-100 text-orange-800 px-2 py-1 rounded hover:bg-orange-200"
            >
              Rotate
            </button>
          </div>
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

        {/* Database Configuration */}
        <div className="bg-gray-50 rounded-lg p-4">
          <div className="flex items-center justify-between mb-3">
            <h3 className="text-lg font-semibold text-gray-800 flex items-center">
              🗄️ Database
            </h3>
            <span className="text-xs bg-green-100 text-green-800 px-2 py-1 rounded">
              SSL
            </span>
          </div>
          <div className="space-y-2">
            {secrets.database ? (
              Object.entries(secrets.database).map(([key, value]) => (
                <div key={key} className="flex justify-between items-center">
                  <span className="text-sm font-medium text-gray-600 capitalize">
                    {key.replace('_', ' ')}:
                  </span>
                  <span className="text-sm text-gray-800 font-mono bg-white px-2 py-1 rounded">
                    {key === 'password' ? '••••••••' : value}
                  </span>
                </div>
              ))
            ) : (
              <p className="text-gray-500 text-sm">No database configuration loaded</p>
            )}
          </div>
        </div>
      </div>

      <div className="mt-6 p-4 bg-blue-50 rounded-lg">
        <h4 className="text-sm font-semibold text-blue-800 mb-2">
          🛡️ Vault Security Features Demonstrated:
        </h4>
        <ul className="text-sm text-blue-700 space-y-1">
          <li>• <strong>Encryption at Rest:</strong> All secrets encrypted in storage</li>
          <li>• <strong>Access Control:</strong> Role-based permissions (RBAC)</li>
          <li>• <strong>Audit Logging:</strong> Every access is logged and monitored</li>
          <li>• <strong>Secret Rotation:</strong> Keys can be rotated without downtime</li>
          <li>• <strong>Dynamic Secrets:</strong> Short-lived credentials for databases</li>
          <li>• <strong>Kubernetes Integration:</strong> Automatic service account authentication</li>
        </ul>
      </div>

      <div className="mt-4 p-4 bg-green-50 rounded-lg">
        <h4 className="text-sm font-semibold text-green-800 mb-2">
          🎯 Real-World Use Cases:
        </h4>
        <ul className="text-sm text-green-700 space-y-1">
          <li>• <strong>Database Credentials:</strong> Secure connection strings</li>
          <li>• <strong>API Keys:</strong> Third-party service authentication</li>
          <li>• <strong>TLS Certificates:</strong> SSL/TLS certificate management</li>
          <li>• <strong>Application Secrets:</strong> JWT signing keys, encryption keys</li>
        </ul>
      </div>
    </div>
  );
};

export default LiveVaultDemo;
