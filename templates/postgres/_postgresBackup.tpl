{{- define "dev.pitlor.homelab.postgresBackup" }}
{{- $globalScope := first . }}
{{- $appName := last . }}
{{- $appPgConfig := index  $globalScope.Values $appName "postgres" }}
apiVersion: postgresql.cnpg.io/v1
kind: ScheduledBackup
metadata:
  name: {{ $appName }}-postgres-backup
  namespace: {{ $appName }}
spec:
  schedule: "0 0 0 * * *"  # Every day at midnight
  backupOwnerReference: self
  cluster:
    name: {{ $appName }}-postgres-{{ $appPgConfig.backupId }}
  method: plugin
  pluginConfiguration:
    name: barman-cloud.cloudnative-pg.io
{{ end }}