#!/bin/bash

mkdir /home/ubuntu/expose_database
touch /home/ubuntu/expose_database/expose.db

./caddy/caddy run --config /var/www/expose/build-config/Caddyfile &
php expose serve dotshare.dev --config=/var/www/expose/build-config/expose.php
