FROM quay.io/keycloak/keycloak:26.4.7 AS builder

ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=authorization,account,account-api,client-policies,impersonation,token-exchange
ENV KC_DB=postgres

COPY --chown=keycloak:keycloak --chmod=644 keycloak-theme.jar /opt/keycloak/providers/
RUN touch -m --date=@1743465600 /opt/keycloak/providers/*

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:26.4.7
WORKDIR /opt/keycloak

COPY --from=builder /opt/keycloak/ /opt/keycloak/

COPY tls.crt /etc/x509/https/tls.crt
COPY tls.key /etc/x509/https/tls.key

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
CMD ["--optimized", "--proxy-headers=forwarded", "--http-enabled=true", "--https-certificate-key-file=/etc/x509/https/tls.key", "--https-certificate-file=/etc/x509/https/tls.crt"]