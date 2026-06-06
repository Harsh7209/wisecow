FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/games:${PATH}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    cowsay \
    fortune-mod \
    fortunes-min \
    netcat-openbsd \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Verify installations
RUN command -v cowsay && \
    command -v fortune && \
    command -v nc && \
    fortune

COPY wisecow.sh /usr/local/bin/wisecow.sh

RUN sed -i 's/\r$//' /usr/local/bin/wisecow.sh && \
    chmod +x /usr/local/bin/wisecow.sh

EXPOSE 4499

ENTRYPOINT ["/usr/local/bin/wisecow.sh"]