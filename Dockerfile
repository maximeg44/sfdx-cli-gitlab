FROM node:18-slim

# Installation des dépendances système nécessaires
RUN apt-get update && apt-get install -y \
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
 && rm -rf /var/lib/apt/lists/*

# Installation du Salesforce CLI et des plugins requis
RUN npm install -g @salesforce/cli@2.87.7 \
 && npm install -g @salesforce/plugin-community \
 && echo y | sf plugins install sfdx-git-delta \
 && echo y | sf plugins install lightning-flow-scanner