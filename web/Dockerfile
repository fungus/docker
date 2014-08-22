FROM ubuntu:trusty
MAINTAINER Lonnie Olson <lonnie@lonnieolson.com>

# Install build dependencies
RUN sed -i 's/archive.ubuntu.com/mirror.sosstaffing.com/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential libssl-dev libpcre3-dev

# Build and install Nginx
ENV NGINX_VERSION 1.6.1
RUN mkdir /usr/src/nginx
WORKDIR /usr/src/nginx
ADD http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz /usr/src/nginx/nginx.tar.gz
RUN tar -zxf nginx.tar.gz --strip-components=1
RUN ./configure \
		--user=www-data \
		--group=www-data \
		--prefix=/usr/local/nginx \
		--sbin-path=/usr/local/sbin/nginx \
		--http-log-path=/proc/self/fd/1 \
		--error-log-path=/proc/self/fd/2 \
		--with-http_gzip_static_module \
		--with-http_spdy_module \
		--with-http_ssl_module \
		--with-http_stub_status_module \
		--with-ipv6 \
		--with-pcre-jit
RUN make -j"$(nproc)" 
RUN make install

# Cleanup
WORKDIR /usr/local/nginx
RUN apt-get -y remove build-essential libssl-dev libpcre3-dev
RUN apt-get -y autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /usr/src/nginx

# Configure
ADD nginx.conf /usr/local/nginx/conf/

VOLUME /var/www
EXPOSE 80
CMD ["/usr/local/sbin/nginx"]
