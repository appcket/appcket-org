FROM node:15 as node

ARG env=production
ENV NODE_ENV=$env

WORKDIR /src

COPY . /src

RUN npm install

RUN npm run build

FROM nginx:stable-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=node /src/nginx.conf /etc/nginx/nginx.conf
COPY --from=node /src/certs/tls.crt /etc/nginx/certs/tls.crt
COPY --from=node /src/certs/tls.key /etc/nginx/certs/tls.key

COPY --from=node /src/public/ /usr/share/nginx/html
COPY --from=node /src/.cache/ /usr/share/nginx/html

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]