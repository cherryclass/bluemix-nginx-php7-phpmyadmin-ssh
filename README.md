<h1> nginx1.13 php7 with access ssh</h1>
<br>
<h2>Phpmyadmin</h2>
Not working for the moment<br>
<br>
<h2>ssh - Filezilla</h2>
sudo passwd myuser<br>
<br>
or for bluemix:<br>
bx ic exec -it my_container bash<br>
sudo passwd myuser<br>
<br>
on Filezilla : your ip - myuser - your password - port 22<br><br>

<h1> Bluemix</h1>
You need to set port with -p on bx ic run or start the container via web console, EXPOSE not work.
