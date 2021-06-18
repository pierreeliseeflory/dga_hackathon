#!/usr/bin/env python3

from datetime import date
import time
import requests
import re

from dgacollection.Cryptolocker import Cryptolocker

print("Malware waiting...")
time.sleep(1)
print("Malware waking up")

domains = (Cryptolocker.domains())
number_domains_generated = (len(Cryptolocker.domains()))

number_domains_poc = 30

def get(domain):
    url = 'https://' + domain
    try:
        r = requests.get(url)
        print(r.status_code)
        if r.status_code == 200:
            print(r.json())
    except requests.exceptions.ConnectionError as err:
        code_search = re.search("Errno ([-+]?[0-9]+)", err.args[0].reason.args[0])
        if code_search:
    	    code = int(code_search.group(1))
        if (code == -3): 
            print("NXDOMAIN for " + domain)
        else :
            print("Received response from c2-server (" + domain + ")")

for domain in range (number_domains_poc) :
    dga_domain = domains[domain]
    get(dga_domain)

while True:
    time.sleep(10)