FROM buildpack-deps:jessie-scm

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

WORKDIR /app

COPY go-wrapper /usr/local/bin/
