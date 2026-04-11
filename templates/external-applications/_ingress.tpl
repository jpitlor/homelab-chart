{{- define "dev.pitlor.homelab.externalApplications.ingress" -}}
{{- $ := index . 0 -}}
{{- $appConfig := index . 1 -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ printf "%s-%s-%s" $.Release.Name "ingress" $appConfig.name | trunc 63 | trimSuffix "-" }}
  namespace: homelab
  annotations:
    gethomepage.dev/enabled: "true"
    gethomepage.dev/description: {{ $appConfig.description | quote }}
    gethomepage.dev/icon: {{ $appConfig.icon | quote }}
    gethomepage.dev/name: {{ $appConfig.name | quote }}
    gethomepage.dev/group: {{ $appConfig.group | quote }}
    gethomepage.dev/href: "https://{{ $appConfig.listenToHost }}"
    gethomepage.dev/siteMonitor: "https://{{ $appConfig.listenToHost }}"
    gethomepage.dev/pod-selector: ""
spec:
  ingressClassName: "traefik"
  rules:
    - host: {{ $appConfig.listenToHost | quote }}
      http:
        paths:
          - backend:
              service:
                name: {{ printf "%s-%s-%s" $.Release.Name "service" $appConfig.name | trunc 63 | trimSuffix "-" | quote }}
                port:
                  name: "http"
            path: "/"
            pathType: "Prefix"
{{- end -}}