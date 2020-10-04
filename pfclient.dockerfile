FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
	libc6 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /tmp

RUN wget $(wget -qO- https://planefinder.net/sharing/client | egrep armhf.deb | awk -F\" '{print $2}') \
	&& apt-get install libc6-dev-armhf-cross \
    && dpkg --add-architecture armhf \
    && dpkg --add-architecture arm64 \
    && dpkg -i pfclient*armhf.deb

ENTRYPOINT ["/usr/bin/pfclient"]
