{{- define "dev.pitlor.homelab.postgresBackup" }}
apiVersion: postgresql.cnpg.io/v1
kind: ScheduledBackup
metadata:
  name: {{ .appName }}-postgres-backup
  namespace: {{ .appName }}
spec:
  schedule: "0 0 0 * * *"  # Every day at midnight
  backupOwnerReference: self
  cluster:
    name: {{ .appName }}-postgres
{{- end }}