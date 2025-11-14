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

CMD ["node", "dist/main"]