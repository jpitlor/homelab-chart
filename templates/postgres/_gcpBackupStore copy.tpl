{{- define "dev.pitlor.homelab.gcpBackupStore" }}
apiVersion: barmancloud.cnpg.io/v1
kind: ObjectStore
metadata:
  name: {{ .appName }}-backup-store
spec:
  retentionPolicy: "30d"
  configuration:
    destinationPath: "gs://dev-pitlor-homelab-container-backups/{{ .appName }}/postgresBackups-{{ .backupId }}"
    googleCredentials:
      applicationCredentials:
        name: backup-creds
        key: gcsCredentials
    wal:
      compression: gzip
{{- end }}