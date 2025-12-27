{{- define "dev.pitlor.homelab.postgresDatabase" }}
{{- $globalScope := first . }}
{{- $appPgConfig := last . }}
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: {{ $appPgConfig.appName }}-postgres-{{ $appPgConfig.backupId }}
  namespace: {{ $appPgConfig.appName }}
spec:
  {{ if $appPgConfig.imageName }}
  imageName: {{ $appPgConfig.imageName }}
  {{ end }}
  instances: 1
  postgresUID: 0
  postgresGID: 0

  {{- if $appPgConfig.sharedPreloadLibraries }}
  postgresql:
    shared_preload_libraries:
      {{- range $appPgConfig.sharedPreloadLibraries }}
      - {{ . }}
      {{- end }}
  {{- end }}

  managed:
    roles:
      - name: {{ $appPgConfig.appName }}
        superuser: true
        login: true

  bootstrap:
    {{- if $appPgConfig.recoverFromBackupId }}
    recovery:
      source: clusterBackup
      database: {{ $appPgConfig.appName }}
      owner: {{ $appPgConfig.appName }}
      secret:
        name: {{ $appPgConfig.appName }}-postgres-secret
      {{- if $appPgConfig.recoverFromBackupTime }}
      recoveryTarget:
        targetTime: {{ $appPgConfig.recoverFromBackupTime | quote }}
      {{- end }}
    {{- else }}
    initdb:
      database: {{ $appPgConfig.appName }}
      owner: {{ $appPgConfig.appName }}
      secret:
        name: {{ $appPgConfig.appName }}-postgres-secret
      {{- if $appPgConfig.postInitSQL }}
      postInitSQL:
        {{- range $appPgConfig.postInitSQL }}
        - {{ . }}
        {{- end }}
      {{- end }}
      {{- if $appPgConfig.postInitApplicationSQLRefs }}
      postInitApplicationSQLRefs:
        configMapRefs:
{{ toYaml $appPgConfig.postInitApplicationSQLRefs | indent 10 }}
      {{- end }}
    {{- end }}
  
  {{- if $appPgConfig.recoverFromBackupId }}
  externalClusters:
    - name: clusterBackup
      plugin:
        name: barman-cloud.cloudnative-pg.io
        parameters:
          barmanObjectName: {{ $appPgConfig.appName }}-restore-store
          serverName: {{ $appPgConfig.appName }}-postgres-{{ $appPgConfig.recoverFromBackupId }}
  {{- end }}

  storage:
    size: {{ $appPgConfig.storageSize | default "4Gi" }}
    storageClass: postgresql

  plugins:
    - name: barman-cloud.cloudnative-pg.io
      isWALArchiver: true
      parameters:
        barmanObjectName: {{ $appPgConfig.appName }}-backup-store
{{ end }}