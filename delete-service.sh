#!/bin/sh
#
# Delete the deployed service
#
gcloud run services delete projector-rider --region europe-west1 --project yascr-365610 --quiet

