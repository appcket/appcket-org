FROM quay.io/keycloak/keycloak:24.0.3 as builder

ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=authorization,account3,account-api,client-policies,impersonation,token-exchange
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:24.0.3
#ADD themes/appcket /opt/jboss/keycloak/themes/appcket
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak

COPY tls.crt /etc/x509/https/tls.crt
COPY tls.key /etc/x509/https/tls.key

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
CMD ["--optimized", "--proxy=edge", "--https-certificate-key-file=/etc/x509/https/tls.key", "--https-certificate-file=/etc/x509/https/tls.crt"]