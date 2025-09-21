apiVersion: v1
kind: Secret
metadata:
  name: gcp-credentials
  namespace: {{ .appName }}
type: Opaque
stringData:
  serviceAccountJson: {{ .Values.google.serviceAccountJson | base64enc }}