{{- define "dev.pitlor.homelab.postgresSecret" }}
{{- $globalScope := first . }}
{{- $appName := last . }}
{{- $appPgConfig := index  $globalScope.Values.applications $appName "postgres" }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ $appName }}-postgres-secret
  namespace: {{ $appName }}
type: kubernetes.io/basic-auth
data:
  username: {{ $appName | b64enc }}
  password: {{ $appName | b64enc }}
{{ end }}