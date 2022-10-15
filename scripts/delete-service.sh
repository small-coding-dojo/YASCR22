#!/bin/sh
#
# Delete the deployed service
#
set -euxf

# Source helper scripts
. "${0%/*}/read-env.sh"

read_env

gcloud run services delete "${IMAGE}" --region europe-west1 --project yascr-365610 --quiet
