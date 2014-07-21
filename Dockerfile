FROM debian:jessie
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

RUN echo "deb http://http.debian.net/debian jessie main contrib non-free" > /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install -y abyss

ADD Procfile /
ADD run /

ENTRYPOINT ["/run"]
