#!/bin/bash
set -e

ORG=${ORG:-hsldevcom}
DOCKER_TAG=${TRAVIS_BUILD_NUMBER:-latest}
DOCKER_IMAGE=$ORG/jore-geometry-matcher:${DOCKER_TAG}
DOCKER_IMAGE_LATEST=$ORG/jore-geometry-matcher:latest

docker build --tag=$DOCKER_IMAGE .

docker tag $DOCKER_IMAGE $DOCKER_IMAGE_LATEST
docker push $DOCKER_IMAGE_LATEST
