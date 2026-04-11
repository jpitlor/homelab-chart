{{- define "dev.pitlor.homelab.externalApplications.endpoint-slice" -}}
{{- $ := index . 0 -}}
{{- $appConfig := index . 1 -}}
apiVersion: discovery.k8s.io/v1
kind: EndpointSlice
metadata:
  name: {{ printf "%s-%s-%s" $.Release.Name "slice" $appConfig.name | trunc 63 | trimSuffix "-" | quote }}
  labels:
    kubernetes.io/service-name: {{ printf "%s-%s-%s" $.Release.Name "service" $appConfig.name | trunc 63 | trimSuffix "-" | quote }}
    endpointslice.kubernetes.io/managed-by: dev.pitlor
addressType: IPv4
ports:
  - name: http
    appProtocol: http
    protocol: TCP
    port: {{ $appConfig.forwardToPort }}
endpoints:
  - addresses:
      - {{ $appConfig.forwardToIp | quote }}
{{- end -}}
