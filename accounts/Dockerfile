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
