# Inspired by https://github.com/simdjson/simdjson/blob/master/Dockerfile

FROM ubuntu:22.04

ARG USER_ID
ARG GROUP_ID
ARG WORKSPACE_DIR=/workspace
ARG DOCKERBUILD_DIR=docker-build
ARG BOOTSTRAP_DIR=/home/user/bootstrap

RUN apt-get update -qq
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install \
    tzdata \
    procps curl file git unzip rsync \
    build-essential autoconf bison patch rustc \
    libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev \
    libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev \
    flex libxml2-dev libgdk-pixbuf2.0-dev libcairo2-dev libpango1.0-dev fonts-lyx cmake \
    libzstd-dev libwebp-dev pngquant

# These sparse files do not behave well for large UIDs
RUN rm /var/log/faillog /var/log/lastlog

# Let's not run as root
RUN addgroup --gid $GROUP_ID user; exit 0
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user; exit 0
RUN mkdir $WORKSPACE_DIR && chown $USER_ID.$GROUP_ID $WORKSPACE_DIR

USER user

# Defer to our bootstrap script to setup our image
RUN mkdir -p ${BOOTSTRAP_DIR}
COPY docker-bootstrap.sh ${BOOTSTRAP_DIR}/docker-bootstrap.sh
COPY Gemfile ${BOOTSTRAP_DIR}/Gemfile
RUN /bin/bash -- ${BOOTSTRAP_DIR}/docker-bootstrap.sh

WORKDIR $WORKSPACE_DIR

CMD /bin/bash ./docker-run.sh