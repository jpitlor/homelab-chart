{{- define "dev.pitlor.homelab.open-archiver.persistent-volume-claim" -}}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: meilisearch-pvc
  namespace: open-archiver
spec:
  storageClassName: "ssd"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: data-pvc
  namespace: open-archiver
spec:
  storageClassName: "ssd"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mail-ingest-pvc
  namespace: open-archiver
  labels:
    "velero.io/exclude-from-backup": "true"
spec:
  storageClassName: "ingest"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
{{- end -}}
