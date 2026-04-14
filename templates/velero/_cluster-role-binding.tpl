{{- define "dev.pitlor.homelab.velero.cluster-role-binding" -}}
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: velero-restore-reader-binding
  annotations:
    "helm.sh/hook": pre-install,pre-upgrade
    "helm.sh/hook-weight": "5"
    "helm.sh/hook-delete-policy": before-hook-creation
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: velero-restore-reader
subjects:
  - kind: ServiceAccount
    name: velero-restore-waiter
    namespace: homelab
{{- end -}}