#!/bin/sh
#
# Keep all projector instances running, even if they are idle.
#
# The gcloud update command below disables auto-shut-down when idle for each service.
# For detailed documentation, see README.md in this folder,
# section "Deployment Aspects".
#
set -euxf

# Source helper scripts
. "${0%/*}/read-env.sh"

read_env

for INDEX in $(seq 1 ${NUM_INSTANCES}); do
    SERVICE_NAME="${IMAGE}-${INDEX}"
    gcloud beta run services update "${SERVICE_NAME}" \
      --project yascr-365610  \
      --image "europe-west1-docker.pkg.dev/yascr-365610/docker-repository/${IMAGE}" \
      --port 8887 \
      --memory 16G \
      --cpu 4 \
      --no-cpu-throttling \
      --min-instances 1 \
      --max-instances 1 \
      --region europe-west1
done
