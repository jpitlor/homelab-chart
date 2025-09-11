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
      {{- if .recoverFromBackupTime }}
      recoveryTarget:
        targetTime: {{ .recoverFromBackupTime | quote }}
      {{- end }}
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
    - name: source
      plugin:
        name: barman-cloud.cloudnative-pg.io
        parameters:
          barmanObjectName: {{ .appName }}-restore-store
          serverName: {{ .appName }}-postgres
  {{- end }}

  storage:
    size: {{ .storageSize | default "4Gi" }}
    storageClass: postgresql

  plugins:
    - name: barman-cloud.cloudnative-pg.io
      isWALArchiver: true
      parameters:
        barmanObjectName: {{ .appName }}-backup-store
{{ end }}