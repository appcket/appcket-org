System Context & Architecture Overview

This repo is a starter kit and example full stack application that provides the foundation for an event-driven, realtime system. There are minimal request/response style actions. Events can be produced and consumed anywhere throughout the system (e.g. from a user in the UI, from an ai agent, from the system via a cronjob).

The UI uses a GraphQL API to send queries and mutations to the eventbus (Redpanda). Other system components, including a dedicated UI event consumer (UiGateway) can consume only UI related events. It pushes them to the UI in realtime where UI components and pages consume them. A Postgres database stores the current state of the application. Any application update occurs within a transaction which also creates an event row in the Outbox table. A Sequin-based monitor watches the Outbox table and produces events based on any new rows it sees there. The Redpanda event stream gets logged to Clickhouse for long term storage and any reporting/analysis needs.

1. Local Dev Environment & Stack

- OS: Windows 11 (WSL2) with Rancher Desktop (K3s).
- Service Mesh: Istio Ambient Mode (No sidecars, using Ztunnel + Waypoint proxies).
- Ingress: Kubernetes Gateway API (Shared Gateway model).
- Identity: Keycloak (running in-cluster as accounts).
- Messaging: Redpanda (running in-cluster).
- Apps: NestJS API, React SPA (app), Astro Marketing site (marketing).
- Postgres database running in Rancher Desktop via docker compose.
- Local Docker Registry running in Rancher Desktop via docker compose that is used to store built images for use in k3s.

1. Key Architectural Decisions

- Split-Persona Gateway: Infrastructure is separated from the application.
  - Platform: A specific istio-gateway Helm chart deploys the Gateway resource and Certificates in the istio-system namespace.
  - Product: The application Helm charts (appcket) only contain HTTPRoute resources that attach to the shared istio-system-gateway.
- Domain Strategy: We use the `.test` TLD (e.g., appcket.test) instead of .localhost.
  - Reason: To prevent client-side resolvers/Node.js from short-circuiting DNS to 127.0.0.1 inside pods.
  - Windows hosts file maps *.appcket.test to 127.0.0.1.

1. Critical Configuration Fixes

- CoreDNS Patch (Hairpinning): To fix "JWT Issuer Mismatch" errors (where the API rejects tokens because internal connection strings don't match the public issuer), we patched CoreDNS.
  - Config: A rewrite rule maps regex (.*\\.)?appcket\.test to the internal ClusterIP of the Istio Gateway service (istio-system-gateway-istio...).
  - Result: Internal pods resolve public URLs to the Gateway's internal IP, preserving the Host header and Protocol.
- Internal Trust: We copy the root-ca-secret from cert-manager into application namespaces.
  - The API pod mounts this CA and uses NODE\_EXTRA\_CA_CERTS to trust the self-signed Gateway certificate during internal "hairpin" calls.
- Keycloak: configured with KC\_PROXY\_HEADERS: xforwarded to handle Istio termination correctly.
- Redpanda:
  - TLS Disabled: We rely on Istio mTLS.
  - Port Naming: Service port named tcp-kafka to ensure Istio treats it as TCP (fixing "Wrong SSL Version" errors).
- Application Binding: All Node/Astro apps are configured to bind to 0.0.0.0 (not 127.0.0.1) and allow all Host headers (allowedHosts: true) to satisfy the Waypoint proxy connection.

1. Current Status

- Egress: Currently set to default (ALLOW_ANY). Attempted strict egress control but reverted it to stabilize the environment; Will revisit later.
- Deployment: A bootstrap.sh is available for initial dev env setup and a start.sh script is for running the app locally after a computer restart for example. Need to look into automating the scripts with a more robust system like go-task.