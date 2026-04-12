{{- define "dev.pitlor.homelab.calibre-web-automated.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: calibre-web-automated
  namespace: calibre-web-automated
spec:
  selector:
    app: calibre-web-automated
  ports:
    - name: web
      protocol: TCP
      port: 8083
      targetPort: 8083
    - name: library
      protocol: TCP
      port: 8080
      targetPort: 8080
  type: ClusterIP
{{- end -}}
