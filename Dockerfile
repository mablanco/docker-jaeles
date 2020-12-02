FROM golang:1.15.5-alpine3.12 as builder
ENV GO111MODULE=on \
    GOOS=linux
RUN apk add git gcc libc-dev
RUN go get -v -ldflags "-linkmode external -extldflags -static" -u github.com/jaeles-project/jaeles

FROM alpine:3.12.1
COPY --from=builder /go/bin/jaeles /bin/jaeles
RUN adduser -D -g '' jaeles
USER jaeles
WORKDIR /home/jaeles
RUN mkdir .jaeles && chown jaeles .jaeles
EXPOSE 5000
ENTRYPOINT ["/bin/jaeles"]
