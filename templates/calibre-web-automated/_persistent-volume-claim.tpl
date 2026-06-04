{{- define "dev.pitlor.homelab.calibre-web-automated.persistent-volume-claim" -}}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: config-pvc
  namespace: calibre-web-automated
spec:
  storageClassName: "ssd"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: library-pvc
  namespace: calibre-web-automated
spec:
  storageClassName: "ssd"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi # TODO: This needs to be expanded
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: plugins-pvc
  namespace: calibre-web-automated
spec:
  storageClassName: "ssd"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: book-ingest-pvc
  namespace: calibre-web-automated
spec:
  storageClassName: "ingest"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
{{- end -}}
