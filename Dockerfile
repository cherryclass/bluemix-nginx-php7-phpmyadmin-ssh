FROM debian:stretch-slim

MAINTAINER Luc Frébourg

ENV NGINX_VERSION 1.13.0-1~stretch
ENV NJS_VERSION   1.13.0.0.1.10-1~stretch
ENV DEBIAN_FRONTEND noninteractive


RUN echo 'starting' 
RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)

RUN echo 'aptitude' 
RUN apt-get install --no-install-recommends --no-install-suggests -y \
    aptitude \
    apt-utils
  
RUN echo 'package' 
RUN aptitude install -y\
	sudo \
    nano \
    ssh \
    nginx \
php7.0-fpm

# php7.0-fpm will not start if this directory does not exist
RUN mkdir /run/php

# configure NGINX as non-daemon
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN useradd -ms /bin/bash myuser
RUN mkdir /home/myuser/www

ADD index.php /home/myuser/www/index.php
ADD nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443 110 137 138 143 145 22 23 25 53
EXPOSE 139/udp 445/udp

ENTRYPOINT service ssh restart && bash
STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]

