FROM debian:stretch-slim

MAINTAINER Luc Frébourg

ENV NGINX_VERSION 1.13.0-1~stretch
ENV NJS_VERSION   1.13.0.0.1.10-1~stretch
ENV DEBIAN_FRONTEND noninteractive

RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install --no-install-recommends --no-install-suggests -y \
    aptitude \
    apt-utils
    
RUN  echo "deb http://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list \
 	&& apt-get update \
 	&& apt-get install --no-install-recommends --no-install-suggests -y --allow-unauthenticated \
						nginx=${NGINX_VERSION} \
						nginx-module-xslt=${NGINX_VERSION} \
						nginx-module-geoip=${NGINX_VERSION} \
						nginx-module-image-filter=${NGINX_VERSION} \
						nginx-module-njs=${NJS_VERSION} \
						gettext-base 
	
 
RUN aptitude install -y\
	sudo \
   	nano \
    	ssh \
    	nginx \
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

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
	
STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
