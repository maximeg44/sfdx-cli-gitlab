#Node v16.20.0 or above is required.
FROM node:18

# Mise à jour des paquets et installation des outils nécessaires
RUN apt-get update && apt-get install -y \
    git \
    findutils \
    bash \
    unzip \
    curl \
    wget \
    openjdk-8-jre \
    openssh-client \
    perl \
    jq \
  && rm -rf /var/lib/apt/lists/*

# Installation du Salesforce CLI et des plugins requis
RUN npm install -g @salesforce/cli
RUN npm install -g sfdx-git-delta@latest
RUN npm install -g @salesforce/plugin-community