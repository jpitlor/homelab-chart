{{- define "dev.pitlor.homelab.calibre-web-automated.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: calibre-web-automated
  namespace: calibre-web-automated
spec:
  replicas: 1
  selector:
    matchLabels:
      app: calibre-web-automated
  template:
    metadata:
      labels:
        app: calibre-web-automated
    spec:
      containers:
        - name: calibre-web-automated
          image: crocodilestick/calibre-web-automated:v4.0.6
          env:
            - name: PUID
              value: "1000"
            - name: PGID
              value: "1000"
            - name: TZ
              value: America/New_York
          volumeMounts:
            - name: config
              mountPath: /config
            - name: library
              mountPath: /calibre-library
            - name: plugins
              mountPath: /config/.config/calibre/plugins
            - name: ingest
              mountPath: /cwa-book-ingest
      annotations:
        "backup.velero.io/backup-volumes-excludes": ingest
      volumes:
        - name: config
          persistentVolumeClaim:
            claimName: config-pvc
        - name: library
          persistentVolumeClaim:
            claimName: library-pvc
        - name: plugins
          persistentVolumeClaim:
            claimName: plugins-pvc
        - name: ingest
          persistentVolumeClaim:
            claimName: book-ingest-pvc
{{- end -}}
