FROM ubuntu:latest

VOLUME /app
WORKDIR /app

RUN apt-get update -qq
RUN apt-get install -yqq lamp-server^ curl
RUN apt-get install -yqq git
RUN curl -L http://curl.haxx.se/ca/cacert.pem > cacert.pem && \
  curl -sS https://getcomposer.org/installer | php -- --cafile=cacert.pem --install-dir=/usr/bin --filename=composer
RUN composer global require "laravel/installer"
ADD ./apache.conf /etc/apache2/sites-available/main.conf
RUN cd /etc/apache2/sites-enabled && ln -s ../sites-available/main.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf

ENV PATH="$PATH:/root/.composer/vendor/bin/"
CMD bash -c "service apache2 start && tail -F /var/log/apache2/error.log"

