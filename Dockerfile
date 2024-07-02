# Use Ubuntu as the base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
      build-essential \
      curl \
      file \
      git \
      npm \
      unzip \
      wget \
      openjdk-8-jre \
      openssh-client \
      perl \
      jq \
      && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m brewuser

# Switch to the non-root user
USER brewuser
WORKDIR /home/brewuser

# Create a directory for Homebrew
RUN mkdir /home/brewuser/homebrew

# Install Homebrew
RUN curl -fsSL -o install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh \
    && chmod +x install.sh \
    && /bin/bash install.sh --prefix=/home/brewuser/homebrew

# Add Homebrew to PATH for brewuser
ENV PATH="/home/brewuser/homebrew/bin:/home/brewuser/homebrew/sbin:${PATH}"

# Switch back to root to install Salesforce CLI and plugins
USER root

# Install Salesforce CLI and plugins
RUN npm install @salesforce/cli@latest --global \
    && sfdx --version \
    && echo y | sfdx plugins:install sfdx-git-delta \
    && npm install sfdx-git-delta@latest --global \
    && sfdx plugins:install community \
    && sf plugins install @salesforce/sfdx-scanner \
    && sfdx plugins

# Switch back to brewuser to install glab
USER brewuser

# Install glab
RUN brew install glab

# Verify installation
RUN glab --version

# Switch back to root for final setup
USER root
