# Base Image: Ubuntu 22.04
FROM ubuntu:22.04

LABEL maintainer="Kizziama <kizziama@proton.me>"

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# TimeZone
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create new user.
RUN useradd -ms /bin/bash kizziama

# Set working directory.
WORKDIR /home/kizziama

# Install sudo.
RUN apt-get update && apt-get install -y sudo

# Grant sudo access to the user.
RUN echo "kizziama ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Copy the packages.sh script.
COPY install_packages.sh /install_packages.sh

# Set username.
USER kizziama
VOLUME ["/home/kizziama"]

# Run the packages.sh script as sudo.
RUN bash /install_packages.sh
