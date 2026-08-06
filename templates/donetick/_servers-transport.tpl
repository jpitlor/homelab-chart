{{- define "dev.pitlor.homelab.donetick.servers-transport" -}}
apiVersion: traefik.io/v1alpha1
kind: ServersTransport
metadata:
  name: insecure-transport
  namespace: donetick
spec:
  insecureSkipVerify: true
{{- end -}}
