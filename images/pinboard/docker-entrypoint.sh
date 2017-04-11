#!/bin/sh

if [ ! -f "www/composer.json" ]; then

    cd /www

    # get the source for the app
    git clone https://github.com/jagdtiger9/pinboard.git .

    # configure the app
    cat > /www/config/parameters.yml << EOF
db:
  host: ${MYSQL_HOST:-db}
  name: pinba
  user: ${MYSQL_USER:-root}
  pass: ${MYSQL_PASSWORD:-$DB_ENV_MYSQL_ROOT_PASSWORD}
base_url: /
logging:
  long_request_time:
    global: 1.0
    "magicpro": 0.5
  heavy_request:
    global: 30000
  heavy_cpu_request:
    global: 1
locale: en
cache: apc
records_lifetime: P2M
aggregation_period: PT${AGGREGATION_PERIOD}M
pagination:
  row_per_page: 50
secure:
  enable: false
timezone: Europe/Moscow
EOF

    # install the app
    composer install --prefer-source --no-interaction

    # deploy the database tables
    ./console migrations:migrate --no-interaction

    # interactive request for stat process period workaround
    # use cron.d/pinboard (see Dockerfile)
    #echo ${AGGREGATION_PERIOD} | ./console register-crontab | tee ./cron.log 2>&1
fi

exec "$@"
