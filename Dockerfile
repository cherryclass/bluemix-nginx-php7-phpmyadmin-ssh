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
   	ssh \ 
    	php7.0-fpm \
    	php-mysql
	
#create user for ssh use and home for nginx server	
RUN useradd -ms /bin/bash myuser
RUN mkdir /home/myuser/www
ADD index.php /home/myuser/www/index.php
RUN chown -R myuser /home/myuser/www

#add conf php
ADD php.ini /etc/php/7.0/fpm/php.ini
#ADD fastcgi_params /etc/nginx/fastcgi_params
#ADD www.conf /etc/php/7.0/fpm/pool.d/www.conf
#ADD php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf

#add config for nginx server
ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf
ADD wordpress.conf /etc/nginx/wordpress.conf

#start services
CMD service php7.0-fpm start && nginx -g "daemon off;"

#WARNING - not working on bluemix with bx ic run, need to put -p or create container with web console.
EXPOSE 80 443 110 143 145 22 25 53
