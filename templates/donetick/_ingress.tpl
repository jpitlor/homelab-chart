{{- define "dev.pitlor.homelab.donetick.ingress" -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: donetick-ingress
  namespace: donetick
  annotations:
    gethomepage.dev/enabled: "true"
    gethomepage.dev/name: DoneTick
    gethomepage.dev/description: TODO Tracking
    gethomepage.dev/icon: donetick.png
    gethomepage.dev/group: Apps
    gethomepage.dev/pod-selector: ""
spec:
  ingressClassName: traefik
  rules:
  - host: todo.test.pitlor.dev
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: donetick
            port:
              number: 2021
{{- end -}}
