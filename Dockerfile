FROM alpine:3.19

# Enable community repository and install dependencies
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.19/community" >> /etc/apk/repositories && \
    apk add --no-cache \
    bash \
    cowsay \
    fortune \
    netcat-openbsd

# Copy the wisecow script
COPY wisecow.sh /usr/local/bin/wisecow.sh

# Making the script executable
RUN chmod +x /usr/local/bin/wisecow.sh

# Exposing the port
EXPOSE 4499

# Run the wisecow service
ENTRYPOINT ["/usr/local/bin/wisecow.sh"]