#! /bin/bash

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
    echo "    listen-on { localhost; };"
    echo ""
    echo "    forward only;"
    echo "    forwarders { "
    echo "        10.0.0.251;"
    echo "    };"
    echo ""
    echo "    querylog yes;"
    echo "};"

    # Re-establish stdout
    exec 1>&5

    /etc/init.d/bind9 restart

    echo "Blocking ip ${1} because suspicious communications have been detected."
}

new_requests=0
request=$(wc -l /var/log/named/query.log | cut -d' ' -f 1)



while true; do
    sleep 1
    new_requests=$(wc -l /var/log/named/query.log | cut -d' ' -f 1)
    new_requests=$(( new_requests - request ))

    # if [ $new_requests -ge 10 ]
    # then
    #     victim=$( tail -n 1 /var/log/named/query.log | cut -d' ' -f 3 | cut -d# -f 1)
    #     echo "DGA usage detected on ${victim}"
    #     block_victim "${victim}"
    #     break
    # fi
done

while true; do
    sleep 10
done