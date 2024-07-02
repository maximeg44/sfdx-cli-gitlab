# Use Ubuntu as the base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
      build-essential \
      curl \
      file \
      git \
      libxcrypt-compat \
      npm \
      unzip \
      wget \
      openjdk-8-jre \
      openssh-client \
      perl \
      jq \
      && rm -rf /var/lib/apt/lists/*

# Install Salesforce CLI and plugins
RUN npm install @salesforce/cli@latest --global \
    && sfdx --version \
    && echo y | sfdx plugins:install sfdx-git-delta \
    && npm install sfdx-git-delta@latest --global \
    && sfdx plugins:install community \
    && sf plugins install @salesforce/sfdx-scanner \
    && sfdx plugins

# Install Homebrew
RUN mkdir /home/linuxbrew \
    && curl -fsSL -o install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh \
    && chmod +x install.sh \
    && /bin/bash install.sh

# Add Homebrew to PATH
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# Install glab
RUN brew install glab

# Verify installation
RUN glab --version
