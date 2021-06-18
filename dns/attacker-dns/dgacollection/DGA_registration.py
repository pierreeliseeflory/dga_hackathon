#!/usr/bin/env python3

from dgacollection.Cryptolocker import Cryptolocker

import random
import time

domains = (Cryptolocker.domains())
number_domains_generated = (len(Cryptolocker.domains()))

number_domains_poc = 30

random_value = random.randrange(number_domains_poc)

malicious_server = domains[random_value]

def change_domain(domain):
    with open("/domain", 'a') as a_writer:
        a_writer.write(domain)

print("The C2 server is registered at : " + malicious_server)

change_domain(malicious_server)


while True:
    time.sleep(10)