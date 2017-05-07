<h1> nginx php7-fpm with access ssh</h1>
<br>
<h2>Version</h2>
nginx 1.13.0<br>
php7.0-fpm<br>
<br>
<h2>Phpmyadmin</h2>
Not configured for the moment<br>
<br>
<h2>ssh - Filezilla</h2>
Access with bash command on your container and type:<br>
sudo passwd myuser<br>
<br>
on Filezilla : your ip - myuser - your password - port 22<br><br>

<h2> Bluemix</h2>
You need to set port with -p on bx ic run or start the container via web console, EXPOSE not work in DOKERFILE.
