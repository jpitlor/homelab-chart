{{- define "dev.pitlor.homelab.velero.restore" -}}
apiVersion: velero.io/v1
kind: Restore
metadata:
  name: velero-restore-{{ .Values.velero.version }}
  namespace: homelab
  annotations:
    "helm.sh/hook": pre-install
    "helm.sh/hook-weight": "5"
spec:
  itemOperationTimeout: 2h
  scheduleName: pvc-daily-backup
  restorePVs: true
  includeClusterResources: false
  existingResourcePolicy: update
  includedResources:
    - persistentvolumeclaims
    - persistentvolumes
    - secrets
    - configmaps
    - namespaces
  excludedResources:
    - clusters.postgresql.cnpg.io
    - pods
    - deployments
    - replicasets
    - statefulsets
    - daemonsets
    - jobs
    - cronjobs
  includedNamespaces:
    {{- range keys .Values }}
    {{- if (get $.Values .).enabled }}
    - {{ . }}
    {{- end }}
    {{- end }}
{{- end -}}