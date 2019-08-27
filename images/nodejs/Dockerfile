FROM phusion/baseimage
MAINTAINER gimatov@gmail.com

RUN apt-get -y update \
    && apt-get install -y nodejs npm \
    && ln -s /usr/bin/nodejs /usr/bin/node

RUN mkdir /var/nodejs && cd /var/nodejs \
    && npm install redis \
    && npm install express \
    && npm install http \
    && npm install ws \
    && npm install forever -g \
    && npm install socket.io \
    && npm init -y \
    && cd / \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY index.js /var/nodejs/index.js

#RUN ln -sf /dev/stderr /var/log/sphinxsearch/searchd.log \
#    && ln -sf /dev/stdout /var/log/sphinxsearch/query.log

# Expose ports
EXPOSE 8085

VOLUME ["/var/www"]

CMD ["node", "/var/nodejs/index.js"]
