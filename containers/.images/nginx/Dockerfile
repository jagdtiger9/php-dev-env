FROM nginx:stable-alpine

# configs
ADD ./conf/nginx.conf /etc/nginx/nginx.conf
ADD ./conf/nginx-proxy.conf /etc/nginx/nginx-proxy.conf

RUN if [ "$proxy" = "1" ]; then mv -f /etc/nginx/nginx-proxy.conf /etc/nginx/nginx.conf; fi
