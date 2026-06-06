FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    cowsay \
    fortune-mod \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/games:${PATH}"

COPY wisecow.sh /usr/local/bin/wisecow.sh

RUN sed -i 's/\r$//' /usr/local/bin/wisecow.sh && \
    chmod +x /usr/local/bin/wisecow.sh

EXPOSE 4499

ENTRYPOINT ["/usr/local/bin/wisecow.sh"]