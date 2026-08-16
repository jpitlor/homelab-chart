{{- define "dev.pitlor.homelab.sunshine.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: sunshine
  namespace: sunshine
  annotations:
    traefik.ingress.kubernetes.io/service.serversscheme: https
    traefik.ingress.kubernetes.io/service.serverstransport: sunshine-insecure-transport@kubernetescrd
spec:
  selector:
    app: sunshine
  ports:
    {{- range (untilStep 47984 48011 1) }}
    - protocol: TCP
      name: sunshine-tcp-{{ . }}
      port: {{ . }}
      targetPort: {{ . }}
      nodePort: {{ . }}
    {{ end }}
    {{- range (untilStep 47998 48011 1) }}
    - protocol: UDP
      name: sunshine-udp-{{ . }}
      port: {{ . }}
      targetPort: {{ . }}
      nodePort: {{ . }}
    {{- end }}
  type: NodePort
{{- end -}}
