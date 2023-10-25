# syntax=docker/dockerfile:1.4

FROM golang:1.18-alpine AS builder

WORKDIR /code

ENV CGO_ENABLED 0
ENV GOPATH /go
ENV GOCACHE /go-build

COPY . .

RUN go mod init
RUN go build -o /app/main ./main.go

FROM alpine:3.15

WORKDIR /app

COPY --from=builder /app/main /app/main

CMD ["/app/main"]