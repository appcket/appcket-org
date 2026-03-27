FROM node:24-slim
RUN npm install -g @tanstack/cli pnpm
RUN tanstack create app -y
WORKDIR /src
RUN pnpm install && pnpm build
CMD ["pnpm", "start"]