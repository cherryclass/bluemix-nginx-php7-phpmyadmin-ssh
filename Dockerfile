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

RUN mkdir /run/php
RUN useradd -ms /bin/bash myuser
RUN mkdir /home/myuser/www
ADD index.php /home/myuser/www/index.php
#ADD nginx.conf /etc/nginx/nginx.conf
CMD service ssh start && tail -F /var/log/mysql/error.log

#WARNING - not working on bluemix with bx ic run, need to put -p or create container with web console.
EXPOSE 80 443 110 137 138 143 145 22 23 25 53
EXPOSE 139/udp 445/udp
