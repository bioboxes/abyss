FROM debian:jessie
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

RUN echo "deb http://http.debian.net/debian jessie main contrib non-free" > /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install -y libsparsehash-dev libboost-all-dev openmpi-bin gcc build-essential make autoconf bsdmainutils r-base-core

ADD http://kmergenie.bx.psu.edu/kmergenie-1.6741.tar.gz /tmp/kmergenie.tar.gz
RUN mkdir /tmp/kmergenie
RUN tar xzf /tmp/kmergenie.tar.gz --directory /tmp/kmergenie --strip-components=1
RUN cd /tmp/kmergenie && make && make install

ADD https://github.com/bcgsc/abyss/releases/download/1.5.2/abyss-1.5.2.tar.gz /tmp/abyss.tar.gz
RUN mkdir /tmp/abyss
RUN tar xzf /tmp/abyss.tar.gz --directory /tmp/abyss --strip-components=1
RUN cd /tmp/abyss && ./configure && make && make install

ADD run /usr/local/bin/
ADD estimate_kmer /usr/local/bin/
ADD Procfile /

ENTRYPOINT ["run"]
