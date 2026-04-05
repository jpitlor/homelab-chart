{{- define "dev.pitlor.homelab.postgres-name" -}}
{{ last . }}-postgres-{{ index (first .) "Values" "applications" (last .) "postgres" "backupId" }}-rw
{{ end }}
