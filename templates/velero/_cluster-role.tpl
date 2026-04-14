{{- define "dev.pitlor.homelab.velero.cluster-role" -}}
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: velero-restore-reader
  annotations:
    "helm.sh/hook": pre-install,pre-upgrade
    "helm.sh/hook-weight": "5"
    "helm.sh/hook-delete-policy": before-hook-creation
rules:
  - apiGroups: ["velero.io"]
    resources: ["restores"]
    verbs: ["get", "list"]
{{- end -}}