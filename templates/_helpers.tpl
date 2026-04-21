{{- define "dev.pitlor.homelab.postgres-name" -}}
{{ last . }}-postgres-{{ index (first .) "Values" (last .) "postgres" "backupId" }}-rw
{{- end -}}
