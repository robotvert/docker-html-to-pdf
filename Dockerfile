FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

# the nodejs repos uses https, which requires apt-transport-https to be installed
RUN apt-get -q2 update && apt-get -q2 install apt-utils apt-transport-https curl gnupg2 tzdata

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list

RUN apt-get -q2 update && apt-get -q2 install nodejs google-chrome-stable

RUN apt-get -q2 clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g chrome-headless-render-pdf

RUN mkdir /tmp/html-to-pdf
WORKDIR /tmp/html-to-pdf

# A4 sized paper
ENTRYPOINT ["/usr/bin/chrome-headless-render-pdf", "--chrome-option=--no-sandbox", "--include-background", "--no-margins", "--paper-width 8.3", "--paper-height 11.7"]
