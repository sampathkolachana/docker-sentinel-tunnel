FROM golang:1.12 AS builder
RUN go get github.com/RedisLabs/sentinel_tunnel

FROM ubuntu:18.04
COPY --from=builder /go/bin/sentinel_tunnel /usr/local/bin/
COPY entrypoint /usr/local/bin
RUN mkdir /etc/sentinel_tunnel && \
    chown www-data /etc/sentinel_tunnel && \
    chmod g+rwx /etc/sentinel_tunnel && \
    adduser www-data root
ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["/usr/local/bin/sentinel_tunnel", "/etc/sentinel_tunnel/config.json", "/dev/stdout"]
USER www-data
