FROM httpd

# --------------------------------------------------
# 1. Paquets nécessaires
# --------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libapache2-mod-evasive \
        libapache2-mod-security2 \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*


ENV APACHE_LOG_DIR=/usr/local/apache2/logs
RUN mkdir -p $APACHE_LOG_DIR

RUN mkdir -p /var/run/mod_evasive \
    && chown -R www-data:www-data /var/run/mod_evasive

COPY conf/httpd.conf               /usr/local/apache2/conf/httpd.conf
COPY conf.d/                       /usr/local/apache2/conf.d/
COPY certs/                        /usr/local/apache2/conf/certs/


VOLUME /usr/local/apache2/htdocs



EXPOSE 80 443

