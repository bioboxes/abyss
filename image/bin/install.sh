#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

fetch(){
	mkdir -p /usr/local/$2
	TMP=$(mktemp)
	wget $1 --quiet --output-document ${TMP}
	tar xf ${TMP} --directory /usr/local/$2 --strip-components=1
	rm ${TMP}
}


NON_ESSENTIAL_BUILD="wget ca-certificates g++ libsparsehash-dev libboost-dev zlib1g-dev"
ESSENTIAL_BUILD="python-minimal r-base-core make"
RUNTIME="bsdmainutils libpython-stdlib"

# Build dependencies
apt-get update --yes
apt-get install --yes --no-install-recommends ${NON_ESSENTIAL_BUILD} ${ESSENTIAL_BUILD}

fetch http://kmergenie.bx.psu.edu/kmergenie-1.6741.tar.gz kmergenie
cd /usr/local/kmergenie
make
make install



fetch https://github.com/bcgsc/abyss/releases/download/2.0.1/abyss-2.0.1.tar.gz abyss
cd /usr/local/abyss
./configure
make
make install
rm -rf /usr/local/abyss


# Clean up dependencies
apt-get autoremove --purge --yes ${NON_ESSENTIAL_BUILD}
apt-get clean

# Install required files
apt-get install --yes --no-install-recommends ${RUNTIME}
rm -rf /var/lib/apt/lists/*
