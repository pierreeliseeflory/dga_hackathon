#! /bin/bash

# Would be better if it was a rate rather than a number
MAX_NUMBER_NXDOMAIN=2
REFRESH_RATE=0.5
STAT_FILE="/var/log/named/named.stats"

function block_victim() {
    # Save stdout
    exec 5>&1

    # Setup conf.local
    exec > /etc/bind/named.conf.options
    exec 1>> /etc/bind/named.conf.options

    echo "options {"
    echo "    directory \"/var/cache/bind\";"
    echo ""
    echo "    recursion yes;"
    echo "    listen-on {"
    echo "        any;"
    echo "    };"
    echo "    allow-query {"
    echo "        ! ${1};"
    echo "        any;"
    echo "    };"
    echo ""
    echo "    forward only;"
    echo "    forwarders {"
    echo "        10.0.0.251;"
    echo "    };"
    echo ""
    echo "    querylog yes;"
    echo "    zone-statistics yes ;"
    echo "    statistics-file \"$STAT_FILE\";"
    echo "};"

    # Re-establish stdout
    exec 1>&5

    # /etc/init.d/bind9 restart
    rndc reload

    echo "Blocking ip ${1} because suspicious communications have been detected."
}


while true; do
    sleep "$REFRESH_RATE"
    # Produce BIND 9 stats
    : > "$STAT_FILE"
    rndc stats
    # Retrieve NXDOMAIN stats
    NB_NXDOMAIN=$(awk '/\+\+ Outgoing Rcodes \+\+/,/\+\+ Outgoing Queries \+\+/' $STAT_FILE | grep "NXDOMAIN$" | xargs | cut -d' ' -f 1)
    echo "$NB_NXDOMAIN"
    if [[ $NB_NXDOMAIN -gt $MAX_NUMBER_NXDOMAIN ]]
    then
        victim=$( tail -n 1 /var/log/named/query.log | cut -d' ' -f 3 | cut -d# -f 1)
        echo "DGA usage detected on ${victim}"
        block_victim "${victim}"
        break
    fi
done

while true; do
    sleep 10
done