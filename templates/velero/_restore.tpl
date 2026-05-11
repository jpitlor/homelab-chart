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
  scheduleName: pvc-daily-backup
  restorePVs: true
  includeClusterResources: true
  existingResourcePolicy: Update
  excludedResources:
    - clusters.postgresql.cnpg.io
  includedNamespaces:
    {{- range keys .Values }}
    {{- if (get $.Values .).enabled }}
    - {{ . }}
    {{- end }}
    {{- end }}
{{- end -}}