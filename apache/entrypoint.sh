#!/bin/sh
set -e


touch /var/log/apache2/error_admin.log
touch /var/log/apache2/error_extranet.log

service fail2ban start

exec apache2 -DFOREGROUND