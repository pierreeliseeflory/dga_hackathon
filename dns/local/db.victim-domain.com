$TTL    604800
@       IN      SOA     ns1.victim-domain.com. root.victim-domain.com. (
                  3       ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800 )   ; Negative Cache TTL
;
; name servers - NS records
     IN      NS      ns1.victim-domain.com.

; name servers - A records
ns1.victim-domain.com.          IN      A      10.0.0.2

victim-domain.com.        IN      A      10.0.0.3