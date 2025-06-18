FROM node:23-slim

# Set environment variable to avoid some interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV CI=true
ENV FORCE_COLOR=true

# Set working directory
WORKDIR /workspace

# Install system dependencies efficiently
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        findutils \
        bash \
        unzip \
        curl \
        wget \
        openjdk-21-jre-headless \
        openssh-client \
        perl \
        jq \
    && rm -rf /var/lib/apt/lists/*

# Install Salesforce CLI and plugins, clean npm cache
RUN npm install -g @salesforce/cli@latest \
    && npm install -g @salesforce/plugin-community@latest \
    && echo y | sf plugins install sfdx-git-delta \
    && echo y | sf plugins install lightning-flow-scanner \
    && echo y | sf plugins install community \
    && npm cache clean --force

# Default command (optional)
CMD ["bash"]