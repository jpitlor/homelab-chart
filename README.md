# Homelab Chart

To keep my Ansible roles debloated, I've extracted all of the containers I host into this Helm chart.

## Pushing New Versions

```shell
script/new-version.sh <new version number>
```

## Backups

All Postgres databases have daily snapshots at midnight that are backed up to a Google Cloud bucket daily at 2am.

TODO: Make all PVCs back up to GCP through Velero

## Restore

TODO: Figure out how to restore PVCs through Velero

1. In the [bucket](https://console.cloud.google.com/storage/browser?project=dev-pitlor-homelab&prefix=&forceOnBucketsSortingFiltering=true&bucketType=live), use the version management feature to restore the version you want.
2. `curl https://gist.githubusercontent.com/jpitlor/300b5742749ed0161fc73bc456138a33/raw/def692bb4ba0f42e0617942412bf8ba22b173fbf/disaster_recovery.sh | bash -s -- <restore from backup id> <optional restore from time>`