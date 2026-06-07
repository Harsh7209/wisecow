# use an ubuntu base image
FROM ubuntu:22.04

# set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/games:${PATH}"

# install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    cowsay \
    fortune-mod \
    fortunes-min \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# copy the wisecow.sh script into the container
COPY wisecow.sh /usr/local/bin/wisecow.sh

# make the wisecow.sh script executable
RUN sed -i 's/\r$//' /usr/local/bin/wisecow.sh && \
    chmod +x /usr/local/bin/wisecow.sh

# expose the port that wisecow will listen on
EXPOSE 4499

# set the entrypoint to run the wisecow.sh script
ENTRYPOINT ["/usr/local/bin/wisecow.sh"]