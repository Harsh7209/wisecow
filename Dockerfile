FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    cowsay \
    fortune-mod \
    netcat-openbsd \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Verify packages are installed
RUN which cowsay && which fortune && which nc || echo "PACKAGES MISSING"

COPY wisecow.sh /usr/local/bin/wisecow.sh
RUN sed -i 's/\r$//' /usr/local/bin/wisecow.sh && \
    chmod +x /usr/local/bin/wisecow.sh

EXPOSE 4499
ENTRYPOINT ["/usr/local/bin/wisecow.sh"]