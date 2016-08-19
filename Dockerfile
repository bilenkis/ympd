FROM debian:jessie
CMD /usr/local/bin/ympd -h 172.17.0.1 -p 6600 -w 80

RUN set -xe \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -qq  \
    && apt-get install -qq \
        git-core \
        g++ \
        cmake \
        libmpdclient-dev \
        libssl-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

COPY . /usr/src/

RUN cd /usr/src/ympd && \
    mkdir -p build && \
    cd build && \
    cmake .. -DCMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_CXX_COMPILER=/usr/bin/g++ && \
    make && \
    make install && \
    rm -rf /usr/src/ympd
