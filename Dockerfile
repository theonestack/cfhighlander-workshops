##
## Dockerfile required to complete the workshops
##
FROM debian:stretch

# basic softwared
RUN apt-get update && \
    apt-get -qq install \
    ruby \
    git \
    openssh-client \
    python3 \
    awscli

# additional layer for docker
RUN apt-get install -qq curl \
    apt-transport-https \
    ca-certificates \
    gnupg2 \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get -qq install docker-ce
