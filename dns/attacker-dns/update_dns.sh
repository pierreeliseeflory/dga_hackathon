#! /bin/bash

sleep 1

c2server=$( tail -n 1 /domain )

# Save stdout
exec 5>&1

# Setup conf.local
exec > /etc/bind/named.conf.local
exec 1>> /etc/bind/named.conf.local

echo "zone \"${c2server}\" {"
echo "    type master;"
echo "    file \"/etc/bind/zones/db.c2-server.com\";"
echo "};"

# Setup c2-server.com
exec > /etc/bind/zones/db.c2-server.com
exec 1>> /etc/bind/zones/db.c2-server.com

echo "\$TTL    604800"
echo "@       IN      SOA     ns1.${c2server}. root.${c2server}. ("
echo "                  3       ; Serial"
echo "             604800     ; Refresh"
echo "              86400     ; Retry"
echo "            2419200     ; Expire"
echo "             604800 )   ; Negative Cache TTL"
echo ";"
echo "; name servers - NS records"
echo "     IN      NS      ns1.${c2server}."
echo ""
echo "; name servers - A records"
echo "ns1.${c2server}.          IN      A      10.0.0.251"
echo ""
echo "${c2server}.        IN      A      10.0.0.250"

# Re-establish stdout
exec 1>&5

/etc/init.d/bind9 restart

echo "New domain name registered"