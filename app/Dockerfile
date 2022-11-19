FROM node:18 as node

ARG env=production
ENV NODE_ENV=$env

WORKDIR /src

COPY . /src

RUN yarn install

RUN yarn build

FROM nginx:stable-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=node /src/nginx.conf /etc/nginx/nginx.conf
COPY --from=node /src/certs/tls.crt /etc/nginx/certs/tls.crt
COPY --from=node /src/certs/tls.key /etc/nginx/certs/tls.key

COPY --from=node /src/build/ /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]