FROM node:18

ARG env=production
ENV NODE_ENV=$env

WORKDIR /src

COPY . /src

RUN npm install

RUN npm run build

CMD ["node", "dist/main"]