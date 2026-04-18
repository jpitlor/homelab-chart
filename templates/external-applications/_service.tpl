{{- define "dev.pitlor.homelab.externalApplications.service" -}}
{{- $ := index . 0 -}}
{{- $appName := index . 1 -}}
{{- $appConfig := index . 2 -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ printf "%s-%s-%s" $.Release.Name "service" $appName | trunc 63 | trimSuffix "-" | lower | quote }}
  namespace: homelab
spec:
  type: ClusterIP
  clusterIP: None
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: {{ $appConfig.forwardToPort }}
{{- end -}}