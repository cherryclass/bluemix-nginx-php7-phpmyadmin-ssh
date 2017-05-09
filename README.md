# Nginx Php7-fpm with ssh and mysql access
[![N|Solid](http://cherryclass.net/img/nginx.jpg )](https://nginx.org/)[![N|Solid](http://cherryclass.net/img/php7.jpg )](http://php.net)
   
## Version
nginx 1.13.0  
php7.0-fpm  

tag : master, 1.1.1

#### 1.1.1 :
fix ipv6   
fix some wordpress security   
add example to multi site     
drop ssh start in dockerfile (crash php)   
drop unused files
#### 1.1 :
mysql and mariadb connection ok    
fixed pretty permalinks on wordpress

## Quick start

```
docker pull cherryclass/nginx-php7-fpm-ssh
docker run -m 256 --name nginx cherryclass/nginx-php7-fpm-ssh
```
[![N|Solid](http://cherryclass.net/img/bluemix.jpg )](https://console.ng.bluemix.net) 
``` sh
#####Bluemix
docker pull cherryclass/nginx-php7-fpm-ssh-bluemix
bx login -a https://api.ng.bluemix.net
bx ic init
bx ic namespace-get   

#### replace *namespace* by your's
docker tag cherryclass/nginx-php7-fpm-ssh-bluemix:master registry.ng.bluemix.net/*namespace*/nginx-php7-fpm-ssh:master 
docker push registry.ng.bluemix.net/*namespace*/nginx-php7-fpm-ssh:master
   
#### set port in command line or start the container via web console, EXPOSE not work in DOKERFILE.
bx ic run -p 443 -p 80 p 22 --volume somevilumedata:/data/nginx -m 256 --name nginx registry.ng.bluemix.net/mynamespace/nginx-php7-ssh
```


## ssh - Filezilla
Access with bash command on your container
``` sh
### Bluemix
bx ic exec -it my_container bash
```
and set password for *mysuser*, start ssh.
```  sh
$ sudo passwd myuser  
$ etc/init.d/ssh start
```

Start filezilla, putty etc with 
```  sh
yourip - myuser - yourpassword - 22
``` 

## Phpmyadmin
Working on, for the moment, install Phpmyadmin official image in other container with *dbhost* the ip.
```
docker pull phpmyadmin/phpmyadmin
docker run --name myadmin -d -e PMA_HOST=dbhost -p 8080:80 phpmyadmin/phpmyadmin
```
[![N|Solid](http://cherryclass.net/img/logocherry180.png )](http://cherryclass.net)
