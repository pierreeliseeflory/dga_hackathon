# TODO

## Features

* DGA detection by monitoring rate/volume of NXDOMAIN message on the DNS resolver
* Action: stop the device from communicating with the network
* UI to display the potential attacks detected and remediation options (“it was me” unblock device, ...)
* Collect data on the attack
  * Fingerprint the dga (rate, volume, name of domains generated, time of the attack)
  * Metadata on the network, devices affected

## Architecture

* network (docker containers)
  * victim (run the DGA)
  * router/dns (see and filter all communication of the network)
    * runs the solution
      * reads dns response, look for NXDOMAIN
      * detection
      * block communications when something is detected
      * collect data
        * on the DGA (to determine which malware it is)
        * on the "metadata" (network, device)
* client
  * front-end "dashboard"
    * tweak settings
    * get notifications of attacks detected
    * allow to perform recovery actions (like certifying that the traffic was genuine)