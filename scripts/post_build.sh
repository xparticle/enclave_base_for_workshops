#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0
set -e

echo "Build completed on $(date)"
echo "Pushing the Docker images..."
docker push "${BASE_REPOSITORY_URI}:latest"
