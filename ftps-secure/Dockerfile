FROM debian:bookworm

# 1. Paquets : vsftpd + fail2ban + nftables + acl
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        vsftpd fail2ban nftables dos2unix acl && \
    rm -rf /var/lib/apt/lists/*

# 2. Groupes & comptes
RUN groupadd -g 1000 dev && groupadd -g 1001 graph && \
    useradd -u 1000 -g dev   -d /srv/sites -s /bin/bash -m developer && \
    echo "developer:devpass"  | chpasswd && \
    useradd -u 1001 -g graph -d /srv/sites -s /bin/bash -m graphiste && \
    echo "graphiste:graphpass" | chpasswd

# 3. Répertoire chroot
RUN mkdir -p /var/run/vsftpd/empty

# 4. Configuration & scripts
COPY vsftpd.conf   /etc/vsftpd.conf
COPY user_list     /etc/vsftpd/user_list
COPY jail.local    /etc/fail2ban/jail.local
COPY nftables.conf /etc/nftables.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && \
    dos2unix /etc/nftables.conf

EXPOSE 21 21100-21110
CMD ["/entrypoint.sh"]
