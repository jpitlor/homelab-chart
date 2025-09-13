apiVersion: v1
kind: Secret
metadata:
  name: gcp-credentials
  namespace: {{ .appName }}
type: Opaque
stringData:
  ACCESS_KEY_ID: {{ $.Values.google.key }}
  ACCESS_SECRET_KEY: {{ $.Values.google.secret }}