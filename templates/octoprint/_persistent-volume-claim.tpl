{{- define "dev.pitlor.homelab.octoprint.persistent-volume-claim" -}}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: config-pvc
  namespace: octoprint
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
{{- end -}}
