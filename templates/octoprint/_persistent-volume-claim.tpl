{{- define "dev.pitlor.homelab.octoprint.persistent-volume-claim" -}}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: config-pvc
  namespace: octoprint
spec:
  storageClassName: "longhorn"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
{{- end -}}
