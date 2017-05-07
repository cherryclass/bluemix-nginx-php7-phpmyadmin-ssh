FROM nginx:1.13.0

MAINTAINER Luc Frébourg

ENV DEBIAN_FRONTEND noninteractive

#install stuff
RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	aptitude \
    apt-utils
 RUN aptitude install -y\
	sudo \
   	nano \
    ssh \ 
    php7.0-fpm \
	phpmyadmin

#create user for ssh use and home for nginx server	
RUN useradd -ms /bin/bash myuser
RUN mkdir /home/myuser/www

ADD index.php /home/myuser/www/index.php
#change user
ADD nginx.conf /etc/nginx/nginx.conf
#add SCRIPT_FILENAME
ADD fastcgi_params /etc/nginx/fastcgi_params

#all horrible test to solve some problem
#ADD usless/php.ini /etc/php/7.0/fpm/php.ini
#ADD usless/www.conf /etc/php/7.0/fpm/pool.d/www.conf
#ADD usless/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf
#RUN mkdir /run/php
#RUN chown -R myuser /home/myuser/www

#add config for nginx server
ADD default.conf /etc/nginx/conf.d/default.conf

#start services
CMD service ssh start && nginx -g "daemon off;"
CMD service php7.0-fpm start && nginx -g "daemon off;"

#WARNING - not working on bluemix with bx ic run, need to put -p or create container with web console.
EXPOSE 80 443 110 137 138 143 145 22 23 25 53
EXPOSE 139/udp 445/udp