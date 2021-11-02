FROM golang:1.16-buster

RUN \
  apt-get update && \
  apt-get install -y ca-certificates openssl zip && \
  update-ca-certificates && \
  apt-get install -y gcc-mingw-w64-i686 && \
  apt-get install -y gcc-mingw-w64-x86-64 && \
  rm -rf /var/lib/apt

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]