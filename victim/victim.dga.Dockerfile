FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -yqq update && apt-get install -yqq --no-install-recommends\
        python3

