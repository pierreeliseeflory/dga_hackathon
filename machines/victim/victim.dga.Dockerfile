FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -yqq update && apt-get install -yqq --no-install-recommends\
        python3\
        python3-pip

RUN pip install requests

RUN mkdir /malware
COPY dgacollection /malware/dgacollection

