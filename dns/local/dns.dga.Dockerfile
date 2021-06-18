FROM ubuntu:bionic

RUN apt-get update \
  && apt-get install -y \
  bind9 \
  bind9utils \
  bind9-doc

# Enable IPv4
RUN sed -i 's/OPTIONS=.*/OPTIONS="-4 -u bind"/' /etc/default/bind9

# Copy configuration files
COPY named.conf /etc/bind/
COPY named.conf.options /etc/bind/
COPY named.conf.local /etc/bind/
COPY dgame_over.sh /dgame_over.sh

COPY db.victim-domain.com /etc/bind/zones/

RUN mkdir -p /var/log/named \
  && touch /var/log/named/query.log \
  && chown -R bind /var/log/named/ \
  && : > /var/log/named/query.log

RUN /etc/init.d/bind9 restart