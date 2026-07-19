{{- define "dev.pitlor.homelab.velero.restore" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: restore-resource-modifier
  namespace: homelab
  annotations:
    "helm.sh/hook": pre-install
    "helm.sh/hook-weight": "4"
data:
  patch.yaml: |
    version: v1
    resourceModifierRules:
      {{ range tuple "ssd-large" "ingest" "media" "photos" "nextcloud" }}
      - conditions:
          groupResource: persistentvolumeclaims
          matches:
            - path: "/spec/storageClassName"
              value: {{ . | quote }}
        mergePatches:
          - patchData: |
              {
                "metadata": {
                  "annotations": {
                    "pv.kubernetes.io/bind-completed": null,
                    "pv.kubernetes.io/bound-by-controller": null
                  }
                },
                "spec": {
                  "volumeName": null
                }
              }
      {{ end }}
---
apiVersion: velero.io/v1
kind: Restore
metadata:
  name: velero-restore-{{ .Values.velero.version }}
  namespace: homelab
  annotations:
    "helm.sh/hook": pre-install
    "helm.sh/hook-weight": "5"
spec:
  itemOperationTimeout: 2h
  allowPartiallyFailed: true
  scheduleName: pvc-daily-backup
  resourceModifier:
    kind: ConfigMap
    name: restore-resource-modifier
  includedResources:
    - persistentvolumeclaims
    - secrets
    - configmaps
    - namespaces
  excludedResources:
    - clusters.postgresql.cnpg.io
    - persistentvolumes
    - pods
    - deployments
    - replicasets
    - statefulsets
    - daemonsets
    - jobs
    - cronjobs
  includedNamespaces:
    {{- range keys .Values }}
    {{- if (get $.Values .).enabled }}
    - {{ . }}
    {{- end }}
    {{- end }}
{{- end -}}