FROM node:24-slim AS base

ARG env=production
ENV NODE_ENV=$env

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /src

COPY . /src

FROM base AS prod-deps
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

FROM base AS build
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run build

FROM base
COPY --from=prod-deps /src/node_modules /src/node_modules
COPY --from=build /src/dist /src/dist

FROM nginx:stable-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=base /src/nginx.conf /etc/nginx/nginx.conf

COPY --from=base /src/dist/ /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]