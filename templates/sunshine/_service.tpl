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
    {{- range (list 47984 47989 48010) }}
    - protocol: TCP
      name: sunshine-tcp-{{ . }}
      port: {{ . }}
      targetPort: {{ . }}
      nodePort: {{ . }}
    {{ end }}
    {{- range (list 47998 47999 48002 48010) }}
    - protocol: UDP
      name: sunshine-udp-{{ . }}
      port: {{ . }}
      targetPort: {{ . }}
      nodePort: {{ . }}
    {{- end }}
  type: NodePort
{{- end -}}
