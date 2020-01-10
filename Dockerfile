FROM golang:1.13.5-alpine3.10 as builder
RUN apk add git gcc libc-dev
RUN GOOS=linux go get -v -ldflags "-linkmode external -extldflags -static" -u github.com/jaeles-project/jaeles

FROM alpine
WORKDIR /
COPY --from=builder /go/bin/jaeles .
EXPOSE 5000
ENTRYPOINT ["/jaeles"]
