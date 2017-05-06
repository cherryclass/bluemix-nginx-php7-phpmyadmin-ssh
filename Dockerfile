FROM nginx:latest

MAINTAINER Luc Frébourg

ENV DEBIAN_FRONTEND noninteractive

RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install --no-install-recommends --no-install-suggests -y \
    aptitude \
    apt-utils
    
RUN aptitude install -y\
	sudo \
   	nano \
    	ssh \
    	php7.0-fpm

# php7.0-fpm will not start if this directory does not exist
#RUN mkdir /run/php

#RUN useradd -ms /bin/bash myuser
#RUN mkdir /home/myuser/www
#ADD index.php /home/myuser/www/index.php
#ADD nginx.conf /etc/nginx/nginx.conf

#ENTRYPOINT service ssh start && bash

EXPOSE 80 443 110 137 138 143 145 22 23 25 53
EXPOSE 139/udp 445/udp
