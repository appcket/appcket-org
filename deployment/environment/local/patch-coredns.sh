#!/bin/bash
set -euo pipefail

echo "📡 Configuring CoreDNS for .test domain..."

# 1. Define Variables
GATEWAY_SVC="istio-system-gateway-istio.istio-system.svc.cluster.local"
DOMAIN="appcket.test"

# 2. DYNAMICALLY fetch the existing NodeHosts
EXISTING_NODE_HOSTS=$(kubectl get configmap coredns -n kube-system -o jsonpath='{.data.NodeHosts}')

# 3. Construct the new NodeHosts content
# Start with existing content
NODE_HOSTS_CONTENT="$EXISTING_NODE_HOSTS"

# Extract the IP (first field of the first line)
HOST_IP=$(echo "$EXISTING_NODE_HOSTS" | awk '{print $1}' | head -n 1)

# Append host.docker.internal if it's not already there (Idempotency)
if [[ "$NODE_HOSTS_CONTENT" != *"host.docker.internal"* ]]; then
    NODE_HOSTS_CONTENT="${NODE_HOSTS_CONTENT}
${HOST_IP} host.docker.internal"
fi

# 4. Indent the content for YAML (Add 4 spaces to the start of every line)
# This is CRITICAL for valid YAML syntax in the block scalar
INDENTED_NODE_HOSTS=$(echo "$NODE_HOSTS_CONTENT" | sed 's/^/    /')

# 5. Create the temporary manifest
# Note: ${INDENTED_NODE_HOSTS} is placed at the start of the line because it already contains the indentation.
cat <<EOF > coredns-patch.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: coredns
  namespace: kube-system
data:
  Corefile: |
    .:53 {
        errors
        health
        # Explicit Rewrites for each service (Robust & Reliable)
        rewrite name accounts.${DOMAIN} ${GATEWAY_SVC}
        rewrite name appcket.${DOMAIN} ${GATEWAY_SVC}
        rewrite name api.${DOMAIN} ${GATEWAY_SVC}
        rewrite name app.${DOMAIN} ${GATEWAY_SVC}
        rewrite name redpanda.${DOMAIN} ${GATEWAY_SVC}
        rewrite name sequin.${DOMAIN} ${GATEWAY_SVC}

        ready
        kubernetes cluster.local in-addr.arpa ip6.arpa {
          pods insecure
          fallthrough in-addr.arpa ip6.arpa
        }
        hosts /etc/coredns/NodeHosts {
          ttl 60
          reload 15s
          fallthrough
        }
        prometheus :9153
        cache 30
        loop
        reload
        loadbalance
        import /etc/coredns/custom/*.override
        forward . /etc/resolv.conf
    }
    import /etc/coredns/custom/*.server
  NodeHosts: |
${INDENTED_NODE_HOSTS}
EOF

# 6. Apply and Restart
kubectl apply -f coredns-patch.yaml
kubectl rollout restart deployment coredns -n kube-system

# Clean up
rm coredns-patch.yaml
echo "✅ CoreDNS configured."
