# based on https://github.com/chriswayg/tor-server

FROM golang:1.15 AS go-build

# Build obfs4proxy & meek-server
RUN go get -v git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy \
 && go get -v git.torproject.org/pluggable-transports/meek.git/meek-server \
 && cp -rv /go/bin /usr/local/

# ---

FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install --no-install-recommends --no-install-suggests -y \
        ca-certificates \
        apt-transport-https \
        apt-utils \
        gnupg \
        curl \
 # Add torproject.org repository for stable Tor
 && curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import \
 && gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - \
 && echo "deb https://deb.torproject.org/torproject.org focal main" > /etc/apt/sources.list.d/tor.list \
 && echo "deb-src https://deb.torproject.org/torproject.org focal main" >> /etc/apt/sources.list.d/tor.list \
 # Install Tor with GeoIP
 && apt-get update \
 && apt-get install --no-install-recommends --no-install-suggests -y \
        iputils-ping \
        tor \
        tor-geoipdb \
        deb.torproject.org-keyring \
 # Tidy up
 && apt-get purge --auto-remove -y \
        apt-transport-https \
        apt-utils \
        gnupg \
        curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy obfs4proxy & meek-server
COPY --from=go-build /usr/local/bin/ /usr/local/bin/

# Copy entrypoint script
COPY ./entrypoint.sh /usr/local/bin/docker-entrypoint

USER debian-tor

ENTRYPOINT ["docker-entrypoint"]
CMD ["tor", "-f", "/etc/tor/torrc"]
