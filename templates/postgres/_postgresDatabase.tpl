{{- define "dev.pitlor.homelab.postgresDatabase" }}
{{- $globalScope := first . }}
{{- $appName := last . }}
{{- $appPgConfig := index  $globalScope.Values $appName "postgres" }}
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: {{ $appName }}-postgres-{{ $appPgConfig.backupId }}
  namespace: {{ $appName }}
spec:
  {{ if $appPgConfig.imageName }}
  imageName: {{ $appPgConfig.imageName }}
  {{ end }}
  instances: 1
  postgresUID: {{ $appPgConfig.uid | default 0 }}
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
      - name: {{ $appName }}
        superuser: true
        login: true

  bootstrap:
    {{- if $appPgConfig.recoverFromBackupId }}
    recovery:
      source: clusterBackup
      database: {{ $appName }}
      owner: {{ $appName }}
      secret:
        name: {{ $appName }}-postgres-secret
      {{- if $appPgConfig.recoverFromBackupTime }}
      recoveryTarget:
        targetTime: {{ $appPgConfig.recoverFromBackupTime | quote }}
      {{- end }}
    {{- else }}
    initdb:
      database: {{ $appName }}
      owner: {{ $appName }}
      secret:
        name: {{ $appName }}-postgres-secret
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
          barmanObjectName: {{ $appName }}-restore-store
          serverName: {{ $appName }}-postgres-{{ $appPgConfig.recoverFromBackupId }}
  {{- end }}

  storage:
    size: {{ $appPgConfig.storageSize | default "4Gi" }}
    storageClass: "ssd"

  plugins:
    - name: barman-cloud.cloudnative-pg.io
      isWALArchiver: true
      parameters:
        barmanObjectName: {{ $appName }}-backup-store
{{ end }}