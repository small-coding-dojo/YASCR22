#!/bin/sh
#
# Deploy a single docker container to CloudRun
#

# Source helper scripts
. "${0%/*}/read-env.sh"

read_env

gcloud run deploy "${IMAGE}" --project yascr-365610 --image "europe-west1-docker.pkg.dev/yascr-365610/docker-repository/${IMAGE}" --port 8887 --memory 8G --cpu 2 --min-instances default --max-instances 1 --region europe-west1 --allow-unauthenticated
