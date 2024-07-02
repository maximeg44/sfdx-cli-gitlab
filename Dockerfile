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

# Install glab
RUN wget https://github.com/profclems/glab/releases/latest/download/glab_Linux_x86_64.tar.gz \
    && tar -xvzf glab_Linux_x86_64.tar.gz \
    && mv bin/glab /usr/local/bin/ \
    && rm -rf glab_Linux_x86_64.tar.gz bin

# Verify installation
RUN glab --version