FROM golang:1.14.4-alpine3.12 as builder
RUN apk add git gcc libc-dev
RUN GO111MODULE=on GOOS=linux go get -v -ldflags "-linkmode external -extldflags -static" -u github.com/jaeles-project/jaeles

FROM alpine:3.12.0
WORKDIR /
COPY --from=builder /go/bin/jaeles .
EXPOSE 5000
ENTRYPOINT ["/jaeles"]
