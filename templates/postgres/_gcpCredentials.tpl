{{- define "dev.pitlor.homelab.gcpCredentials" }}
{{- $globalScope := first . }}
{{- $appPgConfig := last . }}
apiVersion: v1
kind: Secret
metadata:
  name: gcp-credentials
  namespace: {{ $appPgConfig.appName }}
type: Opaque
stringData:
  serviceAccountJson: {{ $globalScope.Values.google.serviceAccountJson | b64enc }}
{{- end }}