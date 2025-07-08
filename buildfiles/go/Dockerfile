# Base image
FROM golang:1.21

# Set working directory
WORKDIR /app

# Initialize the Go module (using a temporary name for now)
RUN go mod init bitbucket.org/andikaryanto11/go-api-design  # Initialize the module

# Download Go dependencies (will create go.mod and go.sum automatically)
RUN go mod tidy

#copy idrsa
COPY config/sshkey/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Expose port
EXPOSE 8080

# Command to keep the container running for live development
CMD ["tail", "-f", "/dev/null"]
