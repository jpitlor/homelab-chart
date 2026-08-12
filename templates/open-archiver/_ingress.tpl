{{- define "dev.pitlor.homelab.open-archiver.ingress" -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: open-archiver-ingress
  namespace: open-archiver
  annotations:
    gethomepage.dev/enabled: "true"
    gethomepage.dev/description: Mail archive
    gethomepage.dev/icon: sh-open-archiver.png
    gethomepage.dev/name: Open Archiver
    gethomepage.dev/group: Services
    gethomepage.dev/pod-selector: ""
spec:
  ingressClassName: traefik
  rules:
  - host: mail-archive.pitlor.dev
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: open-archiver
            port:
              number: 8080
{{- end -}}
