# node > 14.6.0 is required for the SFDX-Git-Delta plugin
FROM node:lts-alpine

WORKDIR /app

# add useful tools
RUN apk add --update --no-cache \
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
RUN npm install sfdx-cli@7.201.6 --global \
    && sfdx --version \
    && echo y | sfdx plugins:install sfdx-git-delta \
    && sfdx plugins

RUN npm install xml2js glob axios sfdx-git-delta@latest --global
