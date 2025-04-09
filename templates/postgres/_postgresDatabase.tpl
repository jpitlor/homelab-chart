{{- define "dev.pitlor.homelab.postgresDatabase" }}
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: {{ .appName }}-postgres
  namespace: {{ .appName }}
spec:
  {{ if .imageName }}
  imageName: {{ .imageName }}
  {{ end }}
  instances: 1
  postgresUID: 0
  postgresGID: 0

  {{- if .sharedPreloadLibraries }}
  postgresql:
    shared_preload_libraries:
      {{- range .sharedPreloadLibraries }}
      - {{ . }}
      {{- end }}
  {{- end }}

  managed:
    roles:
      - name: {{ .appName }}
        superuser: true
        login: true

  bootstrap:
    {{- if .recoverFromBackupId }}
    recovery:
      source: clusterBackup
    {{- else }}
    initdb:
      database: {{ .appName }}
      owner: {{ .appName }}
      secret:
        name: {{ .appName }}-postgres-secret
      {{- if .postInitSQL }}
      postInitSQL:
        {{- range .postInitSQL }}
        - {{ . }}
        {{- end }}
      {{- end }}
      {{- if .postInitApplicationSQLRefs }}
      postInitApplicationSQLRefs:
        configMapRefs:
{{ toYaml .postInitApplicationSQLRefs | indent 10 }}
      {{- end }}
    {{- end }}
  
  {{- if .recoverFromBackupId }}
  externalClusters:
    - name: clusterBackup
      barmanObjectStore:
        endpointURL: "minio.homelab.svc.cluster.local"
        destinationPath: "s3://{{ .appName }}/postgresBackups-{{ .recoverFromBackupId }}"
        s3Credentials:
          accessKeyId:
            name: {{ .appName }}-minio-secret
            key: ACCESS_KEY_ID
          secretAccessKey:
            name: {{ .appName }}-minio-secret
            key: ACCESS_SECRET_KEY
  {{- end }}

  storage:
    size: {{ .storageSize | default "4Gi" }}
    storageClass: postgresql

  backup:
    retentionPolicy: "30d"
    barmanObjectStore:
      endpointURL: "minio.homelab.svc.cluster.local"
      destinationPath: "s3://{{ .appName }}/postgresBackups-{{ .backupId }}"
      wal:
        compression: gzip
      s3Credentials:
        accessKeyId:
          name: {{ .appName }}-minio-secret
          key: ACCESS_KEY_ID
        secretAccessKey:
          name: {{ .appName }}-minio-secret
          key: ACCESS_SECRET_KEY
{{ end }}