FROM ubuntu:trusty
MAINTAINER Lonnie Olson <lonnie@lonnieolson.com>

VOLUME /var/lib/mysql
EXPOSE 3306
ENTRYPOINT ["/run.sh"]
CMD ["mysqld"]

# Install MySQL and cleanup
RUN apt-get -q update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install mysql-server
RUN rm -rf /var/lib/apt/lists/*

# Misc config changes
ADD listen.cnf /etc/mysql/conf.d/
RUN rm /etc/mysql/conf.d/mysqld_safe_syslog.cnf
RUN sed -i '/^log_error/d' /etc/mysql/my.cnf

# Handle initial customisation on first boot
ADD run.sh /run.sh
RUN chmod +x /run.sh
RUN touch /firstboot

# Default admin creds
ENV MYSQL_USER admin
ENV MYSQL_PASS admin

