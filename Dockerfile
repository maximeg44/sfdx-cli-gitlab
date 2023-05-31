# node > 14.6.0 is required for the SFDX-Git-Delta plugin
FROM node:lts-alpine

#add usefull tools
RUN apk add --update --no-cache  \
      git \
      findutils \
      bash \
      unzip \
      curl \
      wget \
      nodejs \
      npm \
      openjdk8-jre \
      openssh-client \
      perl \
      jq

# install Salesforce CLI from npm
# RUN npm install sfdx-cli@latest-rc --global
# install SFDX-Git-Delta plugin - https://github.com/scolladon/sfdx-git-delta
# install SFDX-Hardis - https://github.com/hardisgroupcom/sfdx-hardis
RUN npm install sfdx-cli@7.198.6 --global \
    && sfdx --version \
    && echo y | sfdx plugins:install sfdx-git-delta \
    && npm install sfdx-git-delta@latest --global \
    && sfdx plugins

RUN npm install xml2js
RUN npm install glob
RUN npm install axios