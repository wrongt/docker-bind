FROM alpine:latest

MAINTAINER pstauffer@confirm.ch

#
# Install all required dependencies.
#

RUN apk --update upgrade && \
    apk add --update bind && \
    rm -rf /var/cache/apk/*


#
# Add named init script.
#

ADD init.sh /init.sh
ADD bindconfig/named.conf /etc/bind/named.conf
ADD bindconfig/wrongt.o.zone /etc/bind/wrongt.o.zone
RUN chmod 750 /init.sh
RUN mkdir -p /var/log/named
RUN mkdir -p /var/run/named


#
# Define container settings.
#

EXPOSE 53/udp

WORKDIR /etc/bind


#
# Start named.
#

CMD ["/init.sh"]
