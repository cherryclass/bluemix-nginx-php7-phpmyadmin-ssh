FROM debian:stretch-slim

MAINTAINER Luc Frébourg

ENV NGINX_VERSION 1.13.0-1~stretch
ENV NJS_VERSION   1.13.0.0.1.10-1~stretch
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y gnupg1 \
	&& \
	NGINX_GPGKEY=573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62; \
	found=''; \
	for server in \
		ha.pool.sks-keyservers.net \
		hkp://keyserver.ubuntu.com:80 \
		hkp://p80.pool.sks-keyservers.net:80 \
		pgp.mit.edu \
	; do \
		echo "Fetching GPG key $NGINX_GPGKEY from $server"; \
		apt-key adv --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$NGINX_GPGKEY" && found=yes && break; \
	done; \
	test -z "$found" && echo >&2 "error: failed to fetch GPG key $NGINX_GPGKEY" && exit 1; \
	apt-get remove --purge -y gnupg1 && apt-get -y --purge autoremove && rm -rf /var/lib/apt/lists/* \
	&& echo "deb http://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
						nginx=${NGINX_VERSION} \
						nginx-module-xslt=${NGINX_VERSION} \
						nginx-module-geoip=${NGINX_VERSION} \
						nginx-module-image-filter=${NGINX_VERSION} \
						nginx-module-njs=${NJS_VERSION} \
						gettext-base \
	&& rm -rf /var/lib/apt/lists/*


RUN (apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install --no-install-recommends --no-install-suggests -y \
    aptitude \
    apt-utils
  
RUN aptitude install -y\
	sudo \
   	nano \
    	ssh \
    	nginx \
	php7.0-fpm

# php7.0-fpm will not start if this directory does not exist
RUN mkdir /run/php

RUN useradd -ms /bin/bash myuser
RUN mkdir /home/myuser/www
ADD index.php /home/myuser/www/index.php
#ADD nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443 110 137 138 143 145 22 23 25 53
EXPOSE 139/udp 445/udp

ENTRYPOINT service ssh start && bash

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
	
STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
