FROM debian:jessie
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

RUN echo "deb http://http.debian.net/debian jessie main contrib non-free" > /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install -y libsparsehash-dev libboost-all-dev openmpi-bin gcc build-essential make autoconf bsdmainutils

ADD https://github.com/bcgsc/abyss/releases/download/1.5.2/abyss-1.5.2.tar.gz /tmp/
RUN tar xzf /tmp/abyss-1.5.2.tar.gz
WORKDIR /abyss-1.5.2
RUN ./configure && make && make install

ADD run /
ADD Procfile /

ENTRYPOINT ["/run"]
