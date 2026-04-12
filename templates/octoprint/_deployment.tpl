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
    spec:
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
