{{- define "dev.pitlor.homelab.gcpBackupStore" }}
{{- $globalScope := first . }}
{{- $appName := last . }}
{{- $appPgConfig := index  $globalScope.Values $appName "postgres" }}
apiVersion: barmancloud.cnpg.io/v1
kind: ObjectStore
metadata:
  name: {{ $appName }}-backup-store
  namespace: {{ $appName }}
spec:
  retentionPolicy: "30d"
  configuration:
    destinationPath: "gs://dev-pitlor-homelab-postgres_backups/{{ $appName }}/postgresBackups-{{ $appPgConfig.backupId }}"
    googleCredentials:
      applicationCredentials:
        name: gcp-credentials
        key: serviceAccountJson
    wal:
      compression: gzip
{{- end }}