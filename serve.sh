#!/bin/bash

./caddy/caddy run --config /var/www/expose/build-config/Caddyfile &
php expose serve dotshare.dev --config=/var/www/expose/build-config/expose.php
