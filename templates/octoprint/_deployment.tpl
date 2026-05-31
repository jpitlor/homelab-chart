{{- define "dev.pitlor.homelab.octoprint.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: octoprint
  namespace: octoprint
spec:
  replicas: 1
  selector:
    matchLabels:
      app: octoprint
  template:
    metadata:
      labels:
        app: octoprint
      annotations:
        "backup.velero.io/backup-volumes": config
    spec:
      securityContext:
        runAsGroup: 1000
        runAsUser: 0
        fsGroup: 1000
        fsGroupChangePolicy: OnRootMismatch
      initContainers:
        - name: init-octoprint
          image: mikefarah/yq:4.53.2
          command:
            - "bash"
            - "-c"
            - "touch /octoprint/octoprint/config.yaml && yq -i '.accessControl.autologinLocal = true | .accessControl.autologinAs = \"admin\" | .accessControl.localNetworks.[0] = \"0.0.0.0/0\"' /octoprint/octoprint/config.yaml"
          volumeMounts:
            - name: config
              mountPath: /octoprint
      containers:
        - name: octoprint
          image: octoprint/octoprint:1.11.7
          env:
            - name: OCTOPRINT_PORT 
              value: "80"
            # - name: ENABLE_MJPG_STREAMER
            #   value: "true"
          # TODO: Mount USB camera and printer
          volumeMounts:
            - name: config
              mountPath: /octoprint
      volumes:
        - name: config
          persistentVolumeClaim:
            claimName: config-pvc
{{- end -}}
