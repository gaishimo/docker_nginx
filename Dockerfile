FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y libgd2-xpm-dev libperl-dev
RUN wget http://nginx.org/download/nginx-1.6.1.tar.gz
RUN tar xvzf nginx-1.6.1.tar.gz
RUN cd nginx-1.6.1 && \
    ./configure --prefix=/usr/local/nginx-1.6.1 --with-pcre --prefix=/usr/local/nginx-1.6.1 --conf-path=/etc/nginx/nginx.conf --with-http_ssl_module --with-http_gzip_static_module --with-http_spdy_module --with-http_image_filter_module --with-http_realip_module --with-http_perl_module && \
    make && make install
RUN ln -s /usr/local/nginx-1.6.1 /usr/local/nginx
RUN ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
RUN mkdir -p /var/log/nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

WORKDIR /etc/nginx
CMD ["nginx"]
EXPOSE 80 443
