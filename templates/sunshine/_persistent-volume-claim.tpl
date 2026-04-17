{{- define "dev.pitlor.homelab.sunshine.persistent-volume-claim" -}}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: games
  namespace: sunshine
  labels:
    "velero.io/exclude-from-backup": "true"
spec:
  resources:
    requests:
      storage: 1Gi # We're purposely using `local-path` which does not enforce the max
  accessModes:
    - ReadWriteOnce
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: home        
  namespace: sunshine
spec:
  storageClassName: "longhorn"
  resources:
    requests:
      storage: 1Gi
  accessModes:
    - ReadWriteOnce
{{- end -}}
