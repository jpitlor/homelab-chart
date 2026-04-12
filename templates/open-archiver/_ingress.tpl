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
    gethomepage.dev/group: Apps
    gethomepage.dev/pod-selector: ""
spec:
  ingressClassName: traefik
  rules:
  - host: mail-archive.test.pitlor.dev
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: open-archiver
            port:
              number: 3000
{{- end -}}
