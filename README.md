# Homelab Chart

Technologies Used: Helm, Kubernetes, Minio

## Pushing New Versions

```shell
gcloud auth application-default print-access-token | helm registry login -u oauth2accesstoken --password-stdin https://us-central1-docker.pkg.dev
helm package .
helm push <FILE> oci://us-central1-docker.pkg.dev/dev-pitlor-homelab/homelab-chart
```
