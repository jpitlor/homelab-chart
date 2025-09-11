{{- define "dev.pitlor.homelab.gcpRestoreStore" }}
{{ if .recoverFromBackupId }}
apiVersion: barmancloud.cnpg.io/v1
kind: ObjectStore
metadata:
  name: {{ .appName }}-restore-store
spec:
  retentionPolicy: "30d"
  configuration:
    destinationPath: "gs://dev-pitlor-homelab-container-backups/{{ .appName }}/postgresBackups-{{ .recoverFromBackupId }}"
    googleCredentials:
      applicationCredentials:
        name: backup-creds
        key: gcsCredentials
    wal:
      compression: gzip
{{- end }}
{{- end }}