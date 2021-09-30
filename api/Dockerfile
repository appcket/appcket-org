FROM node:16

ARG env=production
ENV NODE_ENV=$env

WORKDIR /src

COPY . /src

RUN npm install

RUN npm run build

ENTRYPOINT ["npm", "run", "start:prod"]