{{- define "dev.pitlor.homelab.octoprint.ingress" -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: octoprint-ingress
  namespace: octoprint
  annotations:
    gethomepage.dev/enabled: "true"
    gethomepage.dev/description: 3D Printer
    gethomepage.dev/icon: octoprint.png
    gethomepage.dev/name: OctoPrint
    gethomepage.dev/group: Apps
    gethomepage.dev/pod-selector: ""
spec:
  ingressClassName: traefik
  rules:
  - host: 3dprinter.test.pitlor.dev
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: octoprint
            port:
              number: 80
{{- end -}}
