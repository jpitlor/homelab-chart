{{- define "dev.pitlor.homelab.gcpRestoreStore" }}
{{- $globalScope := first . }}
{{- $appName := last . }}
{{- $appPgConfig := index  $globalScope.Values.applications $appName "postgres" }}
{{ if $appPgConfig.recoverFromBackupId }}
apiVersion: barmancloud.cnpg.io/v1
kind: ObjectStore
metadata:
  name: {{ $appName }}-restore-store
  namespace: {{ $appName }}
spec:
  retentionPolicy: "30d"
  configuration:
    destinationPath: "gs://dev-pitlor-homelab-postgres-backups/{{ $appName }}/postgresBackups-{{ $appPgConfig.recoverFromBackupId }}"
    googleCredentials:
      applicationCredentials:
        name: gcp-credentials
        key: serviceAccountJson
    wal:
      compression: gzip
{{- end }}
{{- end }}