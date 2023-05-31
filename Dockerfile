# node > 14.6.0 is required for the SFDX-Git-Delta plugin
FROM node:16-alpine

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


RUN npm install -g npm@8.1.3

# install Salesforce CLI from npm
# RUN npm install sfdx-cli@latest-rc --global
# install SFDX-Git-Delta plugin - https://github.com/scolladon/sfdx-git-delta
# install SFDX-Hardis - https://github.com/hardisgroupcom/sfdx-hardis
RUN npm install sfdx-cli@7.198.6 --global \
    && sfdx --version \
    && echo y | sfdx plugins:install sfdx-git-delta \
    && npm install sfdx-git-delta@latest --global \
    && sfdx plugins


RUN npm install --verbose xml2js