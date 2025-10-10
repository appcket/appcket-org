FROM node:24

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  bzip2 \
  build-essential \
  python3 \
  gcc \
  make \
  vim \
  net-tools

RUN wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.bashrc" SHELL="$(which bash)" bash -

# Clean up after install
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/*
