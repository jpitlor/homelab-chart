{{- define "dev.pitlor.homelab.sunshine.servers-transport" -}}
apiVersion: traefik.io/v1alpha1
kind: ServersTransport
metadata:
  name: insecure-transport
  namespace: sunshine
spec:
  insecureSkipVerify: true
{{- end -}}
