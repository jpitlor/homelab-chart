{{- define "dev.pitlor.homelab.postgresBackup" }}
{{- $globalScope := first . }}
{{- $appPgConfig := last . }}
apiVersion: postgresql.cnpg.io/v1
kind: ScheduledBackup
metadata:
  name: {{ $appPgConfig.appName }}-postgres-backup
  namespace: {{ $appPgConfig.appName }}
spec:
  schedule: "0 0 0 * * *"  # Every day at midnight
  backupOwnerReference: self
  cluster:
    name: {{ $appPgConfig.appName }}-postgres 
  method: plugin
  pluginConfiguration:
    name: barman-cloud.cloudnative-pg.io
{{ end }}