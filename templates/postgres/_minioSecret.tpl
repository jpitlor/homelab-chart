{{- define "dev.pitlor.homelab.minioSecret" }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .appName }}-minio-secret
  namespace: {{ .appName }}
type: Opaque
stringData:
  ACCESS_KEY_ID: {{ .appName | b64enc }}
  ACCESS_SECRET_KEY: {{ .appName | b64enc }}
{{ end }}