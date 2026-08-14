{{- define "dev.pitlor.homelab.sunshine.persistent-volume-claim" -}}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: games
  namespace: sunshine
spec:
  storageClassName: "ssd-large"
  resources:
    requests:
      storage: 300Gi
  accessModes:
    - ReadWriteOnce
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: home        
  namespace: sunshine
spec:
  storageClassName: "ssd"
  resources:
    requests:
      storage: 2Gi
  accessModes:
    - ReadWriteOnce
{{- end -}}
