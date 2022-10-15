#!/bin/sh
#
# Delete all service instances of any projector image
#
set -euxf

# Source helper scripts
. "${0%/*}/read-env.sh"

read_env

RUNNING_SERVICES=$(gcloud run services list --project yascr-365610 | grep "projector" | awk '{print $2}')

OLD_IFS=$IFS
IFS=$(printf '\n\b')
for SERVICE in $RUNNING_SERVICES; do
    gcloud run services delete "${SERVICE}" --region europe-west1 --project yascr-365610 --quiet
done
IFS=$OLD_IFS
