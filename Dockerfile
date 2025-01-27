#Basic dockerfile
FROM golang:1.20.7 as builder

WORKDIR /app

COPY /cmd/vulcanone/main.go /app/cmd/vulcanone/main.go
COPY /internal /app/internal
COPY go.mod /app/go.mod
COPY go.sum /app/go.sum
COPY /configs /app/configs

RUN go mod download
RUN go mod tidy
RUN go build -o main ./cmd/vulcanone

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/main /app/main

EXPOSE 8080

CMD ["/app/main"]
