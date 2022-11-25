#!/bin/sh
#
# Allow CloudRun auto-scaling to shut down projector instances when idle.
#
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
      --cpu-throttling \
      --min-instances 0
done
