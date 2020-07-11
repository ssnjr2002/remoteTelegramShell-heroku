FROM phusion/baseimage:bionic-1.0.0

# Use baseimage-docker's init system:
CMD ["/sbin/my_init"]

# Install dependencies:
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    sudo \
    wget \
    python3 \
    python3-pip \
    sed \
    busybox \
 && pip3 install pyTelegramBotApi \
 && mkdir -p -vv /stuff

# Set work dir:
WORKDIR /home

# Copy files:
COPY startbot.sh /home/
COPY startup.sh /home/
COPY extras.sh /home/
COPY /stuff /stuff

# Run extras.sh and clean up APT:
RUN sh /home/extras.sh \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Run bot script:
CMD bash /home/startbot.sh
