FROM ubuntu:14.04
MAINTAINER Arne Schauf

# Set the locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y

ADD https://downloads.powerdns.com/releases/deb/pdns-static_3.4.1-1_amd64.deb /tmp/
RUN dpkg -i /tmp/pdns-static_3.4.1-1_amd64.deb

EXPOSE     53
EXPOSE     53/udp
ENTRYPOINT [ "/usr/sbin/pdns_server" ]
CMD        [ "--no-config", "--master", "--daemon=no", \
             "--local-address=0.0.0.0", \
            "--allow-axfr-ips=${PDNS_AXFR_IPS:-127.0.0.0/8}" ]
