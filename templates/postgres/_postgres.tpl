{{- define "dev.pitlor.homelab.postgres" }}

{{- template "dev.pitlor.homelab.gcpCredentials" . }}
---
{{- template "dev.pitlor.homelab.gcpBackupStore" . }}
---
{{- template "dev.pitlor.homelab.gcpRestoreStore" . }}
---
{{- template "dev.pitlor.homelab.postgresSecret" . }}
---
{{- template "dev.pitlor.homelab.postgresDatabase" . }}
---
{{- template "dev.pitlor.homelab.postgresBackup" . }}

{{ end }}