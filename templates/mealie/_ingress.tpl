{{- define "dev.pitlor.homelab.mealie.ingress" -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: mealie-ingress
  namespace: mealie
  annotations:
    gethomepage.dev/enabled: "true"
    gethomepage.dev/description: Recipe management
    gethomepage.dev/icon: mealie.png
    gethomepage.dev/name: Mealie
    gethomepage.dev/group: Apps
    gethomepage.dev/pod-selector: ""
spec:
  ingressClassName: traefik
  rules:
  - host: recipes.test.pitlor.dev
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: mealie
            port:
              number: 9000
{{- end -}}
