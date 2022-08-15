FROM quay.io/keycloak/keycloak:19.0.1 as builder

ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=authorization,account2,account-api,client-policies,impersonation,token-exchange,upload-scripts
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:19.0.1
#ADD themes/appcket /opt/jboss/keycloak/themes/appcket
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
WORKDIR /opt/keycloak

COPY tls.crt /etc/x509/https/tls.crt
COPY tls.key /etc/x509/https/tls.key

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start --https-port=443 --https-certificate-file=/etc/x509/https/tls.crt --https-certificate-key-file=/etc/x509/https/tls.key"]