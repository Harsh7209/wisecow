FROM alpine:3.19

# Install dependencies
RUN apk add --no-cache \
    bash \
    cowsay \
    fortune \
    netcat-openbsd

# Copy the wisecow script
COPY wisecow.sh /usr/local/bin/wisecow.sh

# Make the script executable
RUN chmod +x /usr/local/bin/wisecow.sh

# Expose the port
EXPOSE 4499

# Run the wisecow service
ENTRYPOINT ["/usr/local/bin/wisecow.sh"]
