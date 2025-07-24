FROM node:22

ARG env=production
ENV NODE_ENV=$env

WORKDIR /src

COPY . /src

RUN npm install

RUN npm run build

CMD ["node", "dist/main"]