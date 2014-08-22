docker
======
MySQL
-----
Simple build and run: 
```
docker build -t fungus/mysql mysql
docker run -d -p 3306:3306 --name db fungus/mysql 
```
NGINX
-----
Simple build and run:
```
docker build -t fungus/web web
docker run -d -p 80:80 --name web fungus/web
```
PHP-FPM
-------
Simple build and run:
```
docker build -t fungus/php php
docker run -d -p 9000:9000 --name php fungus/php
```

Linking
-------
mkdir ~/webroot/html
echo "<?php phpinfo(); ?>" ~/webroot/html/index.php
docker build -t fungus/mysql mysql
docker build -t fungus/web web
docker build -t fungus/php php
docker run -d --name mysql fungus/mysql
docker run -d --name php -v ~/webroot:/var/www --link mysql:mysql fungus/php
docker run -d --name web -p 80:80 --volumes-from php --link php:php fungus/web

