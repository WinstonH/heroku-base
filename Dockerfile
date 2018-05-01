FROM winstonpro/ubuntu-desktop:heroku-xmr
USER root

ADD https://storage.googleapis.com/v2ray-docker/v2ray /usr/bin/v2ray/
ADD https://storage.googleapis.com/v2ray-docker/v2ctl /usr/bin/v2ray/
ADD https://storage.googleapis.com/v2ray-docker/geoip.dat /usr/bin/v2ray/
ADD https://storage.googleapis.com/v2ray-docker/geosite.dat /usr/bin/v2ray/

ENV PATH /usr/bin/v2ray:$PATH
ENV UUID bae4c69e-3fe3-45d4-aaae-43dc34855efc

RUN rm /usr/sbin/entrypoint.sh /etc/supervisord.conf && \
    apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    mkdir /var/log/v2ray/ && \
    chmod +x /usr/bin/v2ray/v2ctl && \
    chmod +x /usr/bin/v2ray/v2ray && \
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig 
COPY entrypoint.sh /usr/sbin/
COPY supervisord.conf /etc/supervisord.conf
COPY config.json /etc/v2ray/config.json
COPY nginx.conf /etc/nginx/

ADD *.txt /home/myuser/xmr-stak/build/bin/

USER myuser 
