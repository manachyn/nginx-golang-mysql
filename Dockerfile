FROM golang:1.18-alpine AS builder

WORKDIR /app

COPY backend/go.mod backend/go.sum ./

RUN GO111MODULE=on go mod download

COPY backend/ .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app/main ./main.go

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/main .

CMD ["./main"]

EXPOSE 8000