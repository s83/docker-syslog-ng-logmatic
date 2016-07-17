FROM alpine:3.4

MAINTAINER Samuel mansour <s83@users.noreply.github.com>

RUN apk add --update syslog-ng && rm -rf /var/cache/apk/* && ln -s /var/log /data

COPY ./syslog-ng.conf /etc/syslog-ng/syslog-ng.conf

# forward syslog logs to docker log collector
RUN ln -sf /dev/stdout /var/log/syslog

EXPOSE 514/tcp 514/udp

VOLUME ["/data"]

CMD ["/usr/sbin/syslog-ng", "-F", "-f", "/etc/syslog-ng/syslog-ng.conf"]
