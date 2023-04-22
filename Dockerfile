FROM alpine:3.17.3
LABEL maintainer="tim@wilfong.me"
EXPOSE 80/tcp

# Install Apache, PHP, and Composer. And enable mod_rewrite in httpd.conf
RUN apk add --no-cache apache2 php81-apache2 php81-phar php81-mbstring php81-openssl php81-curl \
  && EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')" \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")" \
  && if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then \
       >&2 echo 'ERROR: Invalid composer installer checksum'; rm composer-setup.php; exit 1; fi \
  && php composer-setup.php --quiet --install-dir=/usr/local/bin --filename=composer \
  && rm composer-setup.php \
  && sed -i 's#AllowOverride None#AllowOverride All#' /etc/apache2/httpd.conf \
  && sed -i 's/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/' /etc/apache2/httpd.conf \
  && sed -i 's/#LoadModule\ deflate_module/LoadModule\ deflate_module/' /etc/apache2/httpd.conf \
  && sed -i 's/#LoadModule\ expires_module/LoadModule\ expires_module/' /etc/apache2/httpd.conf 

ADD docker-entrypoint.sh /
HEALTHCHECK CMD wget -q --no-cache --spider localhost
ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]
