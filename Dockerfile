FROM nucleotides/docker-base
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

RUN apt-get install -y abyss

ADD run run
ADD split split

ENTRYPOINT ["./run"]
