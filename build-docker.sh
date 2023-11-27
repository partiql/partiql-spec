#!/bin/bash

source run_check.sh

set -e

IMAGE_TAG="partiql-spec-asciidoc"

#DOCKER_ARGS="--platform linux/amd64"
DOCKER_ARGS=""

run_check docker build ${DOCKER_ARGS} -t ${IMAGE_TAG} \
  --build-arg USER_ID=$(id -u) \
  --build-arg GROUP_ID=$(id -g) \
  $(pwd)

run_check docker run ${DOCKER_ARGS} --rm \
  --mount type=bind,source="$(pwd)",target=/workspace \
  ${IMAGE_TAG} /bin/bash --login docker-run.sh "$@"
