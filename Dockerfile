# node > 14.6.0 is required for the SFDX-Git-Delta plugin
FROM node:alpine

#add usefull tools
RUN apk add --update --no-cache  \
      git \
      findutils \
      bash \
      unzip \
      curl \
      wget \
      openjdk8-jre \
      openssh-client \
      perl \
      jq 

# install Salesforce CLI from npm
# RUN npm install sfdx-cli@latest-rc --global
# install SFDX-Git-Delta plugin - https://github.com/scolladon/sfdx-git-delta
# install SFDX-Hardis - https://github.com/hardisgroupcom/sfdx-hardis
RUN npm install @salesforce/cli@latest --global \
    && sfdx --version \
    && echo y | sfdx plugins:install sfdx-git-delta \
    && npm install sfdx-git-delta@latest --global \
    && sfdx plugins:install community \
    && sf plugins install @salesforce/sfdx-scanner \
    && sfdx plugins

# node > 14.6.0 is required for the SFDX-Git-Delta plugin
FROM node:alpine

#add usefull tools
RUN apk add --update --no-cache  \
      git \
      findutils \
      bash \
      unzip \
      curl \
      wget \
      openjdk8-jre \
      openssh-client \
      perl \
      jq 

# install Salesforce CLI from npm
# RUN npm install sfdx-cli@latest-rc --global
# install SFDX-Git-Delta plugin - https://github.com/scolladon/sfdx-git-delta
# install SFDX-Hardis - https://github.com/hardisgroupcom/sfdx-hardis
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