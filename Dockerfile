FROM golang:1.20.14-alpine3.19 AS builder
RUN apk add git gcc libc-dev
RUN go install github.com/jaeles-project/jaeles@latest

FROM alpine:3.20.3
COPY --from=builder /go/bin/jaeles /bin/jaeles
RUN apk upgrade --no-cache && \
    adduser -D -g '' jaeles && \
    mkdir /home/jaeles/.jaeles && \
    chown jaeles /home/jaeles/.jaeles
USER jaeles
WORKDIR /home/jaeles
EXPOSE 5000
ENTRYPOINT ["/bin/jaeles"]
