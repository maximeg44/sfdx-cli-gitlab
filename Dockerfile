FROM node:18

# Mettre à jour la liste des paquets
RUN apt-get update

# Installer les paquets nécessaires
RUN apt-get install -y git
RUN apt-get install -y findutils
RUN apt-get install -y bash
RUN apt-get install -y unzip
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y openjdk-17-jre-headless
RUN apt-get install -y openssh-client
RUN apt-get install -y perl
RUN apt-get install -y jq

# Nettoyer le cache d'apt
RUN rm -rf /var/lib/apt/lists/*

# Installation du Salesforce CLI et des plugins requis
RUN npm install -g @salesforce/cli \
      && npm install -g @salesforce/plugin-community
RUN echo y | sf plugins install sfdx-git-delta