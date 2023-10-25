FROM golang:1.16-alpine AS builder

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .

RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/backend

FROM scratch
COPY --from=builder /go/bin/backend /go/bin/backend
EXPOSE 8000
ENTRYPOINT ["/go/bin/backend"]