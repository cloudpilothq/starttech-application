# ---- Build Stage ----
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Copy go mod files and download dependencies first (layer caching)
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/server ./cmd/api/main.go

# ---- Final Stage ----
FROM alpine:3.19

# Add CA certificates for HTTPS calls
RUN apk --no-cache add ca-certificates

WORKDIR /app

# Copy compiled binary from builder
COPY --from=builder /app/server .

# Expose the application port
EXPOSE 8080

# Run the binary
CMD ["./server"]
