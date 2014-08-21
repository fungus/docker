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
