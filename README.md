# bluemix-nginx-php7-phpmyadmin-ssh

Trying to have on <bold>bluemix<bold>: <br><br>




-nginx with a directory www that we can see with ssh: nginx could be set to home/myuser/www <br>
-php7 on nginx<br>
-phpmyadmin with some parameter to link at start with a mariadb on other container<br>


After the start, to ssh like with filezilla working :<br>
bx ic exec -it my_container bash<br>
sudo passwd myuser<br>
cd etc<br>
init.d/ssh start<br>
