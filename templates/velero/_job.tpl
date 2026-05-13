{{- define "dev.pitlor.homelab.velero.job" -}}
apiVersion: batch/v1
kind: Job
metadata:
  name: velero-restore-waiter
  namespace: homelab
  annotations:
    "helm.sh/hook": pre-install,pre-upgrade
    "helm.sh/hook-weight": "10"
    "helm.sh/hook-delete-policy": before-hook-creation
spec:
  backoffLimit: 0
  template:
    spec:
      serviceAccountName: velero-restore-waiter
      restartPolicy: Never
      containers:
        - name: wait
          image: bitnami/kubectl:latest
          command:
            - /bin/sh
            - -c
            - |
              RESTORE_NAME="velero-restore-{{ .Values.velero.version }}"
              NAMESPACE="homelab"
              TIMEOUT=7200  # 2 hours
              ELAPSED=0

              echo "Waiting for Velero Restore '$RESTORE_NAME' to complete..."

              while [ $ELAPSED -lt $TIMEOUT ]; do
                PHASE=$(kubectl get restore "$RESTORE_NAME" -n "$NAMESPACE" \
                  -o jsonpath='{.status.phase}' 2>/dev/null)

                echo "Current phase: ${PHASE:-Pending}"

                if [ "$PHASE" = "Completed" ]; then
                  echo "Restore completed successfully."
                  exit 0
                fi

                if [ "$PHASE" = "Failed" ] || [ "$PHASE" = "PartiallyFailed" ]; then
                  echo "Restore failed with phase: $PHASE"
                  exit 1
                fi

                sleep 10
                ELAPSED=$((ELAPSED + 10))
              done

              echo "Timed out waiting for restore to complete."
              exit 1
{{- end -}}