FROM golang:1.13.6-alpine3.11 as builder
RUN apk add git gcc libc-dev
RUN GOOS=linux go get -v -ldflags "-linkmode external -extldflags -static" -u github.com/jaeles-project/jaeles

FROM alpine:3.11.2
WORKDIR /
COPY --from=builder /go/bin/jaeles .
EXPOSE 5000
ENTRYPOINT ["/jaeles"]
