{{- define "dev.pitlor.homelab.email.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: send
  namespace: email
spec:
  selector:
    app: postfix
  ports:
    - protocol: TCP
      port: 25
      targetPort: 25
  type: ClusterIP
{{- end -}}
