{{- define "dev.pitlor.homelab.postgres-name" }}
{{- $globalScope := first . }}
{{- $appName := last . }}
{{ $appName }}-postgres-{{ (index $globalScope.postgres $appName).backupId }}
{{- end }}

{{- define "dev.pitlor.homelab.postgres-config" }}
{{ .appName }}-postgres-{{ .backupId }}
{{- end }}