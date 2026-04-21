{{- define "dev.pitlor.homelab.gcpCredentials" }}
{{- $globalScope := first . }}
{{- $appName := last . }}
{{- $appPgConfig := index  $globalScope.Values $appName "postgres" }}
apiVersion: v1
kind: Secret
metadata:
  name: gcp-credentials
  namespace: {{ $appName }}
type: Opaque
stringData:
  serviceAccountJson: {{ $globalScope.Values.google.serviceAccountJson | quote }}
{{- end }}