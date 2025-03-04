#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0
set -euo pipefail

# Logging function
log() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*"
}

# Error handling
trap 'log "Error on line $LINENO"' ERR

# Validate required environment variables
if [[ -z "${AWS_DEFAULT_REGION:-}" ]]; then
    log "Error: AWS_DEFAULT_REGION is not set"
    exit 1
fi

if [[ -z "${ECR_BASE_REPO_URI:-}" ]]; then
    log "Error: ECR_BASE_REPO_URI is not set"
    exit 1
fi

log "Logging in to Amazon ECR..."
aws --version

# Login to ECR
aws ecr get-login-password --region "${AWS_DEFAULT_REGION}" | \
    docker login --username AWS --password-stdin "${ECR_BASE_REPO_URI}"

# Set repository URI
BASE_REPOSITORY_URI="${ECR_BASE_REPO_URI}"

# Get commit hash
COMMIT_HASH="$(echo "${CODEBUILD_RESOLVED_SOURCE_VERSION:-}" | cut -c 1-7)"

# Docker operations
log "Pulling base image..."
docker pull "${BASE_REPOSITORY_URI}:latest" || true

log "Listing current images..."
docker images

log "Tagging base image..."
docker tag "${BASE_REPOSITORY_URI}:latest" "enclave_base:latest" || true

log "Listing updated images..."
docker images
