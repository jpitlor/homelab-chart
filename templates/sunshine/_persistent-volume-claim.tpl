{{- define "dev.pitlor.homelab.sunshine.persistent-volume-claim" -}}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: games
  namespace: sunshine
spec:
  resources:
    requests:
      storage: 1Gi # This needs to be expanded by a lot when possible
  accessModes:
    - ReadWriteOnce
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: home        
  namespace: sunshine
spec:
  resources:
    requests:
      storage: 1Gi
  accessModes:
    - ReadWriteOnce
{{- end -}}
