FROM node:23-slim

# Set environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /builds

# Add GitLab CI specific configuration
ENV CI=true
ENV FORCE_COLOR=true

# Install system dependencies efficiently
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        findutils \
        bash \
        unzip \
        curl \
        wget \
        openjdk-17-jre-headless \
        openssh-client \
        perl \
        jq \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Configure git for CI
RUN git config --global --add safe.directory '*'

# Install Salesforce CLI and plugins, clean npm cache
RUN npm install -g @salesforce/cli@latest \
    && npm install -g @salesforce/plugin-community@latest \
    && echo y | sf plugins install sfdx-git-delta \
    && echo y | sf plugins install lightning-flow-scanner \
    && echo y | sf plugins install community \
    && npm cache clean --force

# Pre-create common directories for faster pipeline execution
RUN mkdir -p /builds/cache /builds/sfdx /builds/tmp \
    && chmod -R 777 /builds

# Default command
CMD ["bash"]
