{{- define "dev.pitlor.homelab.gcpRestoreStore" }}
{{ if .recoverFromBackupId }}
apiVersion: barmancloud.cnpg.io/v1
kind: ObjectStore
metadata:
  name: {{ .appName }}-restore-store
  namespace: {{ .appName }}
spec:
  retentionPolicy: "30d"
  configuration:
    destinationPath: "gs://dev-pitlor-homelab-container-backups/{{ .appName }}/postgresBackups-{{ .recoverFromBackupId }}"
    googleCredentials:
      applicationCredentials:
        name: gcp-credentials
        key: serviceAccountJson
    wal:
      compression: gzip
{{- end }}
{{- end }}