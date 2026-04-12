{{- define "dev.pitlor.homelab.email.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postfix
  namespace: email
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postfix
  template:
    metadata:
      labels:
        app: postfix
    spec:
      containers:
        - name: postfix
          image: juanluisbaptiste/postfix:1.9.0
          env:
            - name: SMTP_SERVER
              value: {{ .Values.postfix.server }}
            - name: SMTP_USERNAME
              value: {{ .Values.postfix.username }}
            - name: SMTP_PASSWORD
              value: {{ .Values.postfix.password }}
            - name: SERVER_HOSTNAME
              value: pitlor.dev
{{- end -}}
