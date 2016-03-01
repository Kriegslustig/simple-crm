FROM ubuntu:latest

VOLUME /app
WORKDIR /app

RUN apt-get update -qq
RUN apt-get install -yqq lamp-server^ curl
RUN apt-get install -yqq git
RUN curl -L http://curl.haxx.se/ca/cacert.pem > cacert.pem && \
  curl -sS https://getcomposer.org/installer | php -- --cafile=cacert.pem --install-dir=/usr/bin --filename=composer
RUN composer global require "laravel/installer"

ENV PATH="$PATH:/root/.composer/vendor/bin/"
CMD ["tail", "-F", "/var/log/apache2/error.log"]

