#!/bin/bash
set -e

WEB_ROOT=/srv/sites

# --- droits ---------------------------------
chown -R developer:dev "$WEB_ROOT"
chmod -R 775 "$WEB_ROOT"

for img in "$WEB_ROOT"/{admin.rainbowbank.com,extranet.rainbowbank.com}/images
do
  [ -d "$img" ] && chown -R developer:graph "$img" && chmod -R 775 "$img"
done

# --- nftables + fail2ban ---------------------
nft -f /etc/nftables.conf

systemctl restart fail2ban || service fail2ban restart || true

# --- VSFTPD ----------------------------------
exec /usr/sbin/vsftpd /etc/vsftpd.conf
