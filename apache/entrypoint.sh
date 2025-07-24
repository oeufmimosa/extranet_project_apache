#!/bin/sh
set -e

mkdir -p /usr/local/apache2/logs/evasive

chown -R www-data:www-data /usr/local/apache2/logs/evasive || true

exec httpd -DFOREGROUND