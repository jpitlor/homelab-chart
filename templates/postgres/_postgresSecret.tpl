{{- define "dev.pitlor.homelab.postgresSecret" }}
{{- $globalScope := first . }}
{{- $appPgConfig := last . }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ $appPgConfig.appName }}-postgres-secret
  namespace: {{ $appPgConfig.appName }}
type: kubernetes.io/basic-auth
data:
  username: {{ $appPgConfig.appName | b64enc }}
  password: {{ $appPgConfig.appName | b64enc }}
{{ end }}