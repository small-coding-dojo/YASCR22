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
    gcloud run update "${SERVICE_NAME}" \
      --project yascr-365610  \
      --no-cpu-throttling \
      --min-instances 1
done
