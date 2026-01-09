#!/bin/bash
set -e

# Define the output file for the CA certificate
CA_CERT_FILE="rootCA.crt"

echo "🔐 Extracting Root CA certificate from Kubernetes..."

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null
then
    echo "❌ kubectl could not be found. Please install it and configure it to access your cluster."
    exit 1
fi

# Extract the CA from the cert-manager secret, decode it, and save it.
kubectl get secret root-ca-secret --namespace cert-manager --output="jsonpath={.data['ca\.crt']}" | base64 --decode > "$CA_CERT_FILE"

if [ ! -s "$CA_CERT_FILE" ]; then
    echo "❌ Failed to extract CA certificate. Make sure cert-manager is installed and the 'root-ca-secret' exists in the 'cert-manager' namespace."
    exit 1
fi

echo "✅ Root CA certificate extracted successfully to: $(pwd)/$CA_CERT_FILE"
echo ""
echo "--------------------------------------------------------------------------"
echo "👉 Next Step: Import the certificate into Windows"
echo "--------------------------------------------------------------------------"
echo ""
echo "1. Open PowerShell as an Administrator on your Windows machine."
echo ""
echo "2. Copy and run the following command. It will import the certificate into the correct trust store."
echo ""

# Get the full Windows path to the cert file using `wslpath` for reliability.
if command -v wslpath &> /dev/null; then
    CERT_PATH_WINDOWS=$(wslpath -w "$(pwd)/$CA_CERT_FILE")
    echo "powershell.exe -Command \"certutil.exe -addstore -f 'ROOT' '$CERT_PATH_WINDOWS'\""
else
    # Fallback for older WSL or if wslpath is not available.
    echo "Note: 'wslpath' command not found. You may need to adjust the path below."
    echo "You can find the path by navigating to your project directory from Windows Explorer (it will look like '\\wsl\$...\')"
    echo ""
    echo "certutil.exe -addstore -f \"ROOT\" \"\\wsl\$\<Your-Distro-Name>$(pwd)/$CA_CERT_FILE\""
fi

echo ""
echo "3. After importing, restart your Chromium browser completely (close all windows) for the changes to take effect."
echo ""
echo "🎉 You're all set! Your browser should now trust https://appcket.localhost and https://*.appcket.localhost."
