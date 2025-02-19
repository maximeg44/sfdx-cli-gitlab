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
RUN npm install @salesforce/cli --global \
    && sf --version \
    && echo y | sf plugins install sfdx-git-delta \
    && npm install sfdx-git-delta --global \
    && sf plugins install community 
