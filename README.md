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

### Generate domains

```shell
cd victim
python3 dgacollection/DGA.py
```
