FROM ubuntu:trusty
MAINTAINER Lonnie Olson <lonnie@lonnieolson.com>

# Install PHP and cleanup
RUN sed -i 's/archive.ubuntu.com/mirror.sosstaffing.com/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-fpm
RUN rm -rf /var/lib/apt/lists/*

# Configure
RUN rm /etc/php5/fpm/pool.d/www.conf
ADD fpm-pool.conf /etc/php5/fpm/pool.d/www.conf
RUN sed -i 's#/var/log/php5-fpm.log#/proc/self/fd/2#' /etc/php5/fpm/php-fpm.conf

VOLUME /var/www
EXPOSE 9000
CMD ["/usr/sbin/php5-fpm","--nodaemonize","--fpm-config","/etc/php5/fpm/php-fpm.conf"]

