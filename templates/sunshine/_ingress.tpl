{{- define "dev.pitlor.homelab.sunshine.ingress" -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: sunshine-games-ingress
  namespace: sunshine
spec:
  ingressClassName: traefik
  rules:
  - host: games.pitlor.dev
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: sunshine
            port:
              number: 47989
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: sunshine-config-ingress
  namespace: sunshine
  annotations:
    traefik.ingress.kubernetes.io/router.middlewares: sunshine-authentik@kubernetescrd
    gethomepage.dev/enabled: "true"
    gethomepage.dev/description: Remote Games
    gethomepage.dev/icon: sunshine.png
    gethomepage.dev/name: Sunshine
    gethomepage.dev/group: Services
    gethomepage.dev/pod-selector: ""
spec:
  ingressClassName: traefik
  rules:
  - host: games-config.pitlor.dev
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: sunshine
            port:
              number: 47990
{{- end -}}
