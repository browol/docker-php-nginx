FROM alpine:3.7
LABEL Maintainer="Kittipol <kittipol@digio.co.th>"

# Install packages
RUN apk --no-cache add php5 php5-fpm php5-mysqli php5-json php5-openssl php5-curl \
    php5-zlib php5-xml php5-phar php5-intl php5-dom php5-xmlreader php5-ctype \
    php5-cli php5-gd php5-pdo php5-pdo_mysql php5-soap php5-common php5-zip php5-xmlrpc nginx supervisor curl

# ensure www-data user exists
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Remove default server definition
RUN rm /etc/nginx/conf.d/default.conf

# Configure PHP-FPM
COPY config/www.conf /etc/php5/fpm.d/www.conf

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Make sure files/folders needed by the processes are accessable when they run under the www-data user
RUN chown -R www-data:www-data /run && \
  chown -R www-data:www-data /var/lib/nginx && \
  chown -R www-data:www-data /var/tmp/nginx && \
  chown -R www-data:www-data /var/log/nginx

# Create PHP-FPM Logging file
RUN touch /var/log/php-fpm.log && \
    chown www-data:www-data /var/log/php-fpm.log

# Setup document root
RUN mkdir -p /var/www/html

# Make the document root a volume
VOLUME /var/www/html

# Switch to use a non-root user from here on
USER www-data

# Add application
WORKDIR /var/www/html
COPY --chown=www-data:www-data src/ /var/www/html/

RUN [ -d "/var/www/html/storage" ] \
    && (chown -R www-data:www-data /var/www/html/storage/* && chmod -R 775 /var/www/html/storage/*) \
    || echo "not found directory at path /var/www/html/storage"

# Expose the port nginx is reachable on
EXPOSE 8080

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping
