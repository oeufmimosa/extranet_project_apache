FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apache2 \
        libapache2-mod-security2 \
        libapache2-mod-evasive \
        fail2ban \
        ca-certificates \
        curl \
        python3-systemd\
        iptables \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod ssl headers rewrite security2 evasive reqtimeout

ENV APACHE_LOG_DIR=/var/log/apache2
RUN mkdir -p $APACHE_LOG_DIR/evasive && chown -R www-data:www-data $APACHE_LOG_DIR

COPY conf/apache2.conf /etc/apache2/apache2.conf
COPY conf.d/ /etc/apache2/conf-available/
COPY sites/ /etc/apache2/sites-available/
COPY certs/ /etc/apache2/certs/

RUN a2enmod mpm_event && \
    a2ensite extranet.conf admin.conf && \
    a2dissite 000-default.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY fail2ban/jail.local /etc/fail2ban/jail.local
COPY fail2ban/apache-evasive.conf /etc/fail2ban/filter.d/apache-evasive.conf

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80 443
