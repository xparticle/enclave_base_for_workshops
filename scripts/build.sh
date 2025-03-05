#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0
set -e

export BASE_REPOSITORY_URI="${ECR_BASE_REPO_URI}"
echo "Build started on $(date)"
echo "Building the enclave base Docker image..."
docker build --cache-from "${BASE_REPOSITORY_URI}:latest" -f Dockerfile.base -t "${BASE_REPOSITORY_URI}:latest" -t enclave_base .
