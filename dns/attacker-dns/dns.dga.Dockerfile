FROM ubuntu:bionic

RUN apt-get update \
  && apt-get install -y \
  bind9 \
  bind9utils \
  bind9-doc \
  python3

# Enable IPv4
RUN sed -i 's/OPTIONS=.*/OPTIONS="-4 -u bind"/' /etc/default/bind9

# Copy configuration files
COPY named.conf.options /etc/bind/
COPY named.conf.local /etc/bind/
COPY db.c2-server.com /etc/bind/zones/

RUN mkdir /malware \
  && touch /domain
COPY update_dns.sh /update_dns.sh
COPY dgacollection /malware/dgacollection