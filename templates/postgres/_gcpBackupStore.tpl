{{- define "dev.pitlor.homelab.gcpBackupStore" }}
{{- $globalScope := first . }}
{{- $appPgConfig := last . }}
apiVersion: barmancloud.cnpg.io/v1
kind: ObjectStore
metadata:
  name: {{ $appPgConfig.appName }}-backup-store
  namespace: {{ $appPgConfig.appName }}
spec:
  retentionPolicy: "30d"
  configuration:
    destinationPath: "gs://dev-pitlor-homelab-container-backups/{{ $appPgConfig.appName }}/postgresBackups-{{ $appPgConfig.backupId }}"
    googleCredentials:
      applicationCredentials:
        name: gcp-credentials
        key: serviceAccountJson
    wal:
      compression: gzip
{{- end }}