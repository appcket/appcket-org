FROM node:22

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

# Clean up after install
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/*
