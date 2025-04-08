{{- define "dev.pitlor.homelab.postgres" }}

{{- template "dev.pitlor.homelab.minioSecret" . }}
---
{{- template "dev.pitlor.homelab.postgresSecret" . }}
---
{{- template "dev.pitlor.homelab.postgresDatabase" . }}
---
{{- template "dev.pitlor.homelab.postgresBackup" . }}

{{ end }}