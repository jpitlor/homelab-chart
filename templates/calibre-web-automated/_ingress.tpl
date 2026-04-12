{{- define "dev.pitlor.homelab.calibre-web-automated.ingress" -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: calibre-ingress
  namespace: calibre-web-automated
  annotations:
    gethomepage.dev/enabled: "true"
    gethomepage.dev/description: eBook management
    gethomepage.dev/icon: calibre.png
    gethomepage.dev/name: Calibre
    gethomepage.dev/group: Apps
    gethomepage.dev/pod-selector: ""
spec:
  ingressClassName: traefik
  rules:
  - host: books.test.pitlor.dev
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: calibre-web-automated
            port:
              number: 8083
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: calibre-library-ingress
  namespace: calibre-web-automated
spec:
  ingressClassName: traefik
  rules:
  - host: books-library.test.pitlor.dev
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: calibre-web-automated
            port:
              number: 8080
{{- end -}}
