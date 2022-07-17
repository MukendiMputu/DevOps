# Example of an Image for a simple Webserver
FROM ubuntu:20.04

LABEL maintainer="mukki0729"
LABEL description="Test simple Webserver"

# Umgebungsvariablen und Zeitzone einstellen
# (erspartt interaktive Rückfragen)
ENV TZ="Europe/Berlin" \
    APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2

# zeitzone einstellen, Apache installieren, unnötige Dateien aus dem Paket-Cache gleich wieder entfernen, HTTPS aktivieren
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone && \
    apt-get update && \
    apt-get install -y apache2 && \
    apt-get -y clean && \
    rm -r /var/cache/apt /var/lib/apt/lists/* && \
    a2ensite default-ssl && \
    a2enmod ssl

# Ports 80 und 443 freigeben
EXPOSE 80 443

# Gesamten Inhalt des Projektverzeichnisses samplesite nach /var/www/html kopieren
COPY samplesite/ /var/www/html

# Start command
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]