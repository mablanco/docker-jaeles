FROM golang:1.15.3-alpine3.12 as builder
ENV GO111MODULE=on \
    GOOS=linux
RUN apk add git gcc libc-dev
RUN go get -v -ldflags "-linkmode external -extldflags -static" -u github.com/jaeles-project/jaeles

FROM alpine:3.12.1
WORKDIR /
COPY --from=builder /go/bin/jaeles .
EXPOSE 5000
ENTRYPOINT ["/jaeles"]
