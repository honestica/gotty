FROM golang:1.13.8 AS builder

COPY . /src

WORKDIR /src

RUN make tools

ENV GOPATH="/src:/src/vendor:/"

RUN make cross_compile

FROM alpine:3.11.3 AS final

WORKDIR /

COPY --from=builder /src/builds/pkg/linux_amd64  .
RUN mv src gotty
