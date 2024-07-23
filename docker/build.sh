#!/bin/bash

set -o errexit -o nounset -o pipefail

MACHINE=cpu
DOCKER_TAG="quay.io/chengyu_zhu/torchserve_llm_ipex:qwen7b"
BASE_IMAGE="pytorch/torchserve:latest-cpu"
DOCKER_FILE="Dockerfile.torchserve-qwen7b"
UPDATE_BASE_IMAGE=false
USE_CUSTOM_TAG=false
CUDA_VERSION=""
USE_LOCAL_SERVE_FOLDER=false
BUILD_WITH_IPEX=false
BUILD_CPP=false
BUILD_NIGHTLY=false
BUILD_FROM_SRC=false
LOCAL_CHANGES=true
PYTHON_VERSION=3.9
HTTPS_PROXY=${HTTPS_PROXY:-}
HTTP_PROXY=${HTTP_PROXY:-}
 
cp ../frontend/server/src/main/resources/proto/*.proto .
cp -r ../third_party .
 
DOCKER_BUILDKIT=1 docker build --file "$DOCKER_FILE" --build-arg BASE_IMAGE=$BASE_IMAGE \
       --build-arg http_proxy=${HTTPS_PROXY} \
       --build-arg https_proxy=${HTTP_PROXY} \
       -t "$DOCKER_TAG" .
