FROM node:8

MAINTAINER Alexej Bondarenko

ENV PURESCRIPT_DOWNLOAD_SHA1 5075eced1436d4d5f7a47823f5c4333c1f1d3edc

RUN npm install -g bower pulp@12.3.0

RUN cd /opt \
    && wget https://github.com/purescript/purescript/releases/download/v0.12.2/linux64.tar.gz \
    && echo "$PURESCRIPT_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz

ENV PATH /opt/purescript:$PATH

RUN userdel node
RUN useradd -m -s /bin/bash pureuser

WORKDIR /home/pureuser

USER pureuser

RUN mkdir tmp && cd tmp && pulp init

CMD cd tmp && pulp psci
