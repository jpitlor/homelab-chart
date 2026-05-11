{{- define "dev.pitlor.homelab.applications.namespace" -}}
{{- $ := index . 0 -}}
{{- $appName := index . 1 -}}
{{- $appConfig := index . 2 -}}
apiVersion: v1
kind: Namespace
metadata:
  name: {{ $appName }}
{{- end -}}
