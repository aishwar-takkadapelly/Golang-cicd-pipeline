# Use the Go base image to build and run the application
FROM golang:1.23.0

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source code into the containers
COPY . .

# Build the Go app
RUN go build -o main .

# Install required packages for running the application
RUN apt-get update && apt-get install -y \
    ca-certificates \
    libsqlite3-0 \
    && rm -rf /var/lib/apt/lists/*

# Expose port 8083 to the outside world
EXPOSE 8083

# Run the Go binary
CMD ["./main"]
