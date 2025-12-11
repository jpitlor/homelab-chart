{{- define "dev.pitlor.homelab.gcpRestoreStore" }}
{{- $globalScope := first . }}
{{- $appPgConfig := last . }}
{{ if $appPgConfig.recoverFromBackupId }}
apiVersion: barmancloud.cnpg.io/v1
kind: ObjectStore
metadata:
  name: {{ $appPgConfig.appName }}-restore-store
  namespace: {{ $appPgConfig.appName }}
spec:
  retentionPolicy: "30d"
  configuration:
    destinationPath: "gs://dev-pitlor-homelab-container-backups/{{ $appPgConfig.appName }}/postgresBackups-{{ $appPgConfig.recoverFromBackupId }}"
    googleCredentials:
      applicationCredentials:
        name: gcp-credentials
        key: serviceAccountJson
    wal:
      compression: gzip
{{- end }}
{{- end }}