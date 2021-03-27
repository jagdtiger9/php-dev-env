FROM phusion/baseimage:master
MAINTAINER gimatov@gmail.com

COPY server /var/www

RUN apt-get -y update \
    && apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs \
    && cd /var/www \
    && npm install \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose ports
EXPOSE 8085 1333

VOLUME ["/var/www"]

CMD ["node", "/var/www/server.js"]
