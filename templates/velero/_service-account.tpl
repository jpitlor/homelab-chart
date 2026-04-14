{{- define "dev.pitlor.homelab.velero.service-account" -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: velero-restore-waiter
  namespace: homelab
  annotations:
    "helm.sh/hook": pre-install,pre-upgrade
    "helm.sh/hook-weight": "5"
    "helm.sh/hook-delete-policy": before-hook-creation
{{- end -}}