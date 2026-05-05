{{- define "dev.pitlor.homelab.open-archiver.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: open-archiver
  namespace: open-archiver
spec:
  replicas: 1
  selector:
    matchLabels:
      app: open-archiver
  template:
    metadata:
      labels:
        app: open-archiver
      annotations:
        "backup.velero.io/backup-volumes-excludes": ingest
    spec:
      containers:
        - name: open-archiver
          image: logiclabshq/open-archiver:v0.5.0
          env:
            - name: NODE_ENV
              value: "production"
            - name: PORT_BACKEND
              value: "4000"
            - name: PORT_FRONTEND
              value: "3000"
            - name: APP_URL
              value: https://email-archive.test.pitlor.dev
            - name: ORIGIN
              value: https://email-archive.test.pitlor.dev
            - name: INGESTION_WORKER_CONCURRENCY
              value: "5"
            - name: POSTGRES_DB
              value: open-archiver
            - name: POSTGRES_USER
              value: open-archiver
            - name: POSTGRES_PASSWORD
              value: open-archiver
            - name: DATABASE_URL
              value: "postgresql://open-archiver:open-archiver@{{ template "dev.pitlor.homelab.postgres-name" (list $ "open-archiver") }}:5432/open-archiver"
            - name: MEILI_MASTER_KEY
              value: {{ .Values.openArchiver.meiliMasterKey }}
            - name: MEILI_HOST
              value: http://meilisearch.open-archiver.svc.cluster.local:7700
            - name: REDIS_HOST
              value: valkey.open-archiver.svc.cluster.local
            - name: REDIS_PORT
              value: "6379"
            - name: REDIS_PASSWORD
              value: "open-archiver"
            - name: REDIS_TLS_ENABLED
              value: "false"
            - name: STORAGE_TYPE
              value: local
            - name: BODY_SIZE_LIMIT
              value: Infinity
            - name: JWT_SECRET
              value: {{ .Values.openArchiver.jwtSecret }}
            - name: JWT_EXPIRES_IN
              value: "7d"
            - name: ENCRYPTION_KEY
              value: {{ .Values.openArchiver.encryptionKey }}
            - name: TIKA_URL
              value: http://tika.open-archiver.svc.cluster.local:9998
            - name: STORAGE_LOCAL_ROOT_PATH
              value: /var/data/open-archiver
          volumeMounts:
            - name: data
              mountPath: /var/data/open-archiver
            - name: ingest
              mountPath: /ingest
      volumes:
        - name: data
          persistentVolumeClaim:
            claimName: data-pvc
        - name: ingest
          persistentVolumeClaim:
            claimName: mail-ingest-pvc
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: valkey
  namespace: open-archiver
spec:
  replicas: 1
  selector:
    matchLabels:
      app: valkey
  template:
    metadata:
      labels:
        app: valkey
    spec:
      containers:
        - name: open-archiver
          image: valkey/valkey:8-alpine
          command: ["valkey-server", "--requirepass", "open-archiver"]
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: meilisearch
  namespace: open-archiver
spec:
  replicas: 1
  selector:
    matchLabels:
      app: meilisearch
  template:
    metadata:
      labels:
        app: meilisearch
    spec:
      containers:
        - name: meilisearch
          image: getmeili/meilisearch:v1.15
          env:
            - name: MEILI_MASTER_KEY
              value: "{{ .Values.openArchiver.meiliMasterKey }}"
            - name: MEILI_SCHEDULE_SNAPSHOT
              value: "86400"
          volumeMounts:
            - name: data
              mountPath: /meili_data
      volumes:
        - name: data
          persistentVolumeClaim:
            claimName: meilisearch-pvc
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tika
  namespace: open-archiver
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tika
  template:
    metadata:
      labels:
        app: tika
    spec:
      containers:
        - name: tika
          image: apache/tika:3.2.2.0-full
{{- end -}}
