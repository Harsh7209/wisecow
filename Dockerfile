FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    cowsay \
    fortune \
    netcat-openbsd

# Debug: Check if packages are installed
RUN echo "=== Checking installations ===" && \
    which cowsay || echo "cowsay NOT FOUND" && \
    which fortune || echo "fortune NOT FOUND" && \
    which nc || echo "nc NOT FOUND" && \
    which netcat || echo "netcat NOT FOUND" && \
    echo "=== End of checks ==="

COPY wisecow.sh /usr/local/bin/wisecow.sh
RUN sed -i 's/\r$//' /usr/local/bin/wisecow.sh && \
    chmod +x /usr/local/bin/wisecow.sh

EXPOSE 4499
ENTRYPOINT ["/usr/local/bin/wisecow.sh"]