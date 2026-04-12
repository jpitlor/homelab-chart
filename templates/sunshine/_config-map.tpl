{{- define "dev.pitlor.homelab.sunshine.config-map" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: sunshine-config
  namespace: sunshine
data:
  99-install-heroic-launcher.sh: |-
{{ .Files.Get "files/sunshine/99-install-heroic-launcher.sh" | indent 4 }}
  99-start-udevd.sh: |-
{{ .Files.Get "files/sunshine/99-start-udevd.sh" | indent 4 }}
{{ end }}