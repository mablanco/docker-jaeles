FROM golang:1.14.0-alpine3.11 as builder
RUN apk add git gcc libc-dev
RUN GOOS=linux go get -v -ldflags "-linkmode external -extldflags -static" -u github.com/jaeles-project/jaeles

FROM alpine:3.11.3
WORKDIR /
COPY --from=builder /go/bin/jaeles .
EXPOSE 5000
ENTRYPOINT ["/jaeles"]
