FROM debian:jessie
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

ENV SOURCES="\
  deb http://http.debian.net/debian jessie main contrib non-free \n\
  deb http://debian.bioboxes.org stable main" 

ENV PACKAGES \
	autoconf \
	bsdmainutils \
	g++ \
	libsparsehash-dev \
	libsqlite3-dev \
	make \
	openmpi-bin \
	xz-utils \
        ca-certificates \
        libboost-all-dev \
        wget

RUN echo ${SOURCES} > /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y --no-install-recommends ${PACKAGES}
RUN apt-get install -y --no-install-recommends --allow-unauthenticated validate-biobox-file

ENV ASSEMBLER_DIR /tmp/assembler
ENV ASSEMBLER_URL https://github.com/bcgsc/abyss/releases/download/1.9.0/abyss-1.9.0.tar.gz
ENV ASSEMBLER_BLD ./configure --enable-maxk=128 && make && make install

RUN mkdir ${ASSEMBLER_DIR}
RUN cd ${ASSEMBLER_DIR} &&\
    wget --quiet ${ASSEMBLER_URL} --output-document - |\
    tar xzf - --directory . --strip-components=1 && eval ${ASSEMBLER_BLD} && \
    rm -rf ${ASSEMBLER_DIR}

ADD run /usr/local/bin/
ADD estimate_kmer /usr/local/bin/
ADD Procfile /

ENTRYPOINT ["run"]
