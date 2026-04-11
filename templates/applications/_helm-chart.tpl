{{- define "dev.pitlor.homelab.applications.helm-chart" -}}
{{- $ := index . 0 -}}
{{- $appName := index . 1 -}}
{{- $appConfig := index . 2 -}}
{{ if hasKey $appConfig "repository" }}
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: {{ printf "%s-%s" $.Release.Name $appName | trunc 63 | trimSuffix "-" | quote }}
  namespace: homelab
spec:
  repo: {{ $appConfig.repository }}
  version: {{ $appConfig.version }}
  chart: {{ $appName }}
  targetNamespace: {{ $appName }}
  timeout: 10m
  {{- if $.Files.Get (printf "files/values/%s.yaml" $appName) }}
  valuesContent: |-
{{ tpl ($.Files.Get (printf "files/values/%s.yaml" $appName)) $ | indent 4 }}
  {{- end }}
{{ end }}
{{- end -}}
