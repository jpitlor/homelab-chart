{{- define "dev.pitlor.homelab.gcpBackupStore" }}
apiVersion: barmancloud.cnpg.io/v1
kind: ObjectStore
metadata:
  name: {{ .appName }}-backup-store
  namespace: {{ .appName }}
spec:
  retentionPolicy: "30d"
  configuration:
    destinationPath: "gs://dev-pitlor-homelab-container-backups/{{ .appName }}/postgresBackups-{{ .backupId }}"
    googleCredentials:
      applicationCredentials:
        name: gcp-credentials
        key: serviceAccountJson
    wal:
      compression: gzip
{{- end }}