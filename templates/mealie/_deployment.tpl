{{- define "dev.pitlor.homelab.mealie.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mealie
  namespace: mealie
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mealie
  template:
    metadata:
      labels:
        app: mealie
      annotations:
        "backup.velero.io/backup-volumes": mealie-data
    spec:
      containers:
      - name: mealie
        image: ghcr.io/mealie-recipes/mealie:v3.9.1
        env:
        - name: ALLOW_SIGNUP
          value: "false"
        - name: PUID
          value: "1000"
        - name: PGID
          value: "1000"
        - name: TZ
          value: America/New_York
        - name: BASE_URL
          value: https://recipes.test.pitlor.dev
        - name: DB_ENGINE
          value: postgres
        - name: POSTGRES_USER
          value: mealie
        - name: POSTGRES_PASSWORD
          value: mealie
        - name: POSTGRES_SERVER
          value: {{ template "dev.pitlor.homelab.postgres-name" (list $ "mealie") }}
        - name: POSTGRES_PORT
          value: "5432"
        - name: POSTGRES_DB
          value: mealie
        - name: OIDC_AUTH_ENABLED
          value: "true"
        - name: OIDC_SIGNUP_ENABLED
          value: "true"
        - name: OIDC_CONFIGURATION_URL
          value: https://auth.test.pitlor.dev/application/o/mealie/.well-known/openid-configuration
        - name: OIDC_CLIENT_ID
          value: {{ .Values.mealie.oidcClientId }}
        - name: OIDC_CLIENT_SECRET
          value: {{ .Values.mealie.oidcClientSecret }}
        - name: OIDC_USER_GROUP
          value: "Homelab User"
        - name: OIDC_ADMIN_GROUP
          value: "Homelab Admin"
        - name: OIDC_AUTO_REDIRECT
          value: "true"
        - name: "ALLOW_PASSWORD_LOGIN"
          value: "false"
        - name: "SMTP_HOST"
          value: "send.mail.svc.cluster.local"
        - name: "SMTP_AUTH_STRATEGY"
          value: "NONE"
        - name: "SMTP_FROM_EMAIL"
          value: "noreply@pitlor.dev"
        volumeMounts:
        - name: mealie-data
          mountPath: /app/data/
        startupProbe:
          initialDelaySeconds: 10
          periodSeconds: 5
          exec:
            command:
            - "timeout"
            - "1"
            - "bash"
            - "-c"
            - "cat < /dev/null > /dev/tcp/{{ template "dev.pitlor.homelab.postgres-name" (list $ "mealie") }}/5432"
      volumes:
      - name: mealie-data
        persistentVolumeClaim:
          claimName: mealie-pvc
{{- end -}}
