#!/bin/bash

echo "result=" >> /var/www/vardata/log/indexer.log

/usr/bin/indexer --all --rotate --config /etc/sphinxsearch/sphinx.conf >> /var/www/vardata/log/indexer.log

echo "\n\n" >> /var/www/vardata/log/indexer.log