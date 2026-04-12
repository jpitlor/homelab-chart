{{- define "dev.pitlor.homelab.octoprint.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: octoprint
  namespace: octoprint
spec:
  selector:
    app: octoprint
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
{{- end -}}
