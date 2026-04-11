{{- define "dev.pitlor.homelab.applications.postgres" -}}
{{- $ := index . 0 -}}
{{- $appName := index . 1 -}}
{{- $appConfig := index . 2 -}}
{{- if hasKey $appConfig "postgres" -}}
{{- template "dev.pitlor.homelab.postgres" (list $ $appName) }}
{{- end }}
{{- end -}}
