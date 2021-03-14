FROM nginx:latest
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY conf/nginx.ssl.conf /etc/nginx/conf.d/site.conf
WORKDIR /etc/nginx/ssl/
COPY ssl/nginx.crt .
COPY ssl/nginx.key .
WORKDIR /
RUN chmod 0700 /etc/nginx/ssl
