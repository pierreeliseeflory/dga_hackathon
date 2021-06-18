# Tool to fight the use of Domain Generating Algorithms

## Usage

### Build images

```shell
(cd dns/local/ && docker build -t local-dns -f dns.dga.Dockerfile .)
(cd dns/attacker-dns/ && docker build -t attacker-dns -f dns.dga.Dockerfile .)
(cd machines/victim/ && docker build -t victim -f victim.dga.Dockerfile .)
(cd machines/c2-server/ && docker build -t c2-server .)
```

### Launch proof of concept

```shell
docker-compose up
```

### Access visualization

Go to the [skydive UI](http://localhost:8082/ui/topology).

### Generate domains

```shell
cd victim
python3 dgacollection/DGA.py
```

## Explanation

The attacking DNS (10.0.0.251) registers randomly one of the 100 first domains generated for the C2-server (10.0.0.250). When the victim (10.0.0.3) queries the local DNS (10.0.0.3) (who only knows the location of the victim domain), the query is passed to other DNS (including the attacker's one).

That way the victim (in fact the malware) when spraying DNS request will receive NXDOMAIN for most urls except for the one registered by the attacker. In our PoC, we consider that the single fact that the response is not a NXDOMAIN is enough to assess that the malware has successfully connected to the c2-server.

### Without DGAme-over

#### DNS owned by the attacker

![a](pictures/attackers_dns_no_protection.png)

#### Local victim's DNS

![b](pictures/local_dns_no_protection.png)

#### DGA output from the malware on the victim's machine

![c](pictures/victim_no_protection.png)


### With DGAme-over

#### DNS owned by the attacker

![a](pictures/attackers_dns.png)

#### Local victim's DNS

![b](pictures/local_dns.png)

#### DGA output from the malware on the victim's machine

![c](pictures/victim.png)