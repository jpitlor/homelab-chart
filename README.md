# Homelab Chart

To keep my Ansible roles debloated, I've extracted all of the containers I host into this Helm chart.

## Pushing New Versions

```shell
gcloud auth application-default print-access-token | helm registry login -u oauth2accesstoken --password-stdin https://us-central1-docker.pkg.dev
helm package .
helm push <FILE> oci://us-central1-docker.pkg.dev/dev-pitlor-homelab/homelab-chart
```