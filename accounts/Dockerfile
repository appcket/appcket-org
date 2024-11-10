FROM quay.io/keycloak/keycloak:26.0.5 AS builder

ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=authorization,account,account-api,client-policies,impersonation,token-exchange
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:26.0.5
#ADD themes/appcket /opt/jboss/keycloak/themes/appcket
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak

COPY tls.crt /etc/x509/https/tls.crt
COPY tls.key /etc/x509/https/tls.key

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
CMD ["--optimized", "--proxy-headers=forwarded", "--http-enabled=true", "--https-certificate-key-file=/etc/x509/https/tls.key", "--https-certificate-file=/etc/x509/https/tls.crt"]