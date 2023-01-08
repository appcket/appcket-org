FROM node:18

ARG env=production
ENV NODE_ENV=$env

WORKDIR /src

COPY . /src

RUN yarn

RUN yarn build

CMD ["node", "dist/main"]