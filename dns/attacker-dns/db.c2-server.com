$TTL    604800
@       IN      SOA     ns1.c2-server.com. root.c2-server.com. (
                  3       ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800 )   ; Negative Cache TTL
;
; name servers - NS records
     IN      NS      ns1.c2-server.com.

; name servers - A records
ns1.c2-server.com.          IN      A      10.0.0.251

c2-server.com.        IN      A      10.0.0.250