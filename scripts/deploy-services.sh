#!/bin/sh
#
# Deploy the number of projector instances configured in .env
#
set -euxf

# Source helper scripts
. "${0%/*}/read-env.sh"

read_env

for INDEX in $(seq 1 ${NUM_INSTANCES}); do
    SERVICE_NAME="${IMAGE}-${INDEX}"
    gcloud run deploy "${SERVICE_NAME}" --project yascr-365610 --image "europe-west1-docker.pkg.dev/yascr-365610/docker-repository/${IMAGE}" --port 8887 --memory 16G --cpu 4 --min-instances default --max-instances 1 --region europe-west1 --allow-unauthenticated
done
