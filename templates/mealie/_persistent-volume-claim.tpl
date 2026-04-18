{{- define "dev.pitlor.homelab.mealie.persistent-volume-claim" -}}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mealie-pvc
  namespace: mealie
spec:
  storageClassName: "ssd"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
{{- end -}}
