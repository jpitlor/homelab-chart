# Homelab Chart

Technologies Used: Helm, Kubernetes, Minio

## Pushing New Versions

```shell
script/new-version.sh <new version number>
```

## Backups

All Postgres databases have daily snapshots at midnight that are backed up to a Google Cloud bucket.

Additionally, all PVCs have daily snapshots at 2am that are also backed up to a Google Cloud bucket.

## Restore

1. In the [buckets](https://console.cloud.google.com/storage/browser?project=dev-pitlor-homelab&prefix=&forceOnBucketsSortingFiltering=true&bucketType=live) for both Postgres and the PVCs, use the version management feature to restore the version you want.
2. `curl https://gist.githubusercontent.com/jpitlor/300b5742749ed0161fc73bc456138a33/raw/def692bb4ba0f42e0617942412bf8ba22b173fbf/disaster_recovery.sh | bash -s -- <restore from backup id> <optional restore from time>`
