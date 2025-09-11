#!/bin/bash

# Uprev Chart.yaml
yq -i ".version = \"$1\"" file.yaml
git commit -am "Update version to $1"
git push origin main

# Push new version
gcloud auth application-default print-access-token | helm registry login -u oauth2accesstoken --password-stdin https://us-central1-docker.pkg.dev
helm package .
PACKAGE=$(ls *.tgz)
helm push $PACKAGE oci://us-central1-docker.pkg.dev/dev-pitlor-homelab/homelab-chart
rm $PACKAGE