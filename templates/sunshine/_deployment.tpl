{{- define "dev.pitlor.homelab.sunshine.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sunshine
  namespace: sunshine
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sunshine
  template:
    metadata:
      labels:
        app: sunshine
      annotations:
        "backup.velero.io/backup-volumes-excludes": "games-dir"
    spec:
      runtimeClassName: nvidia
      containers:
        - name: sunshine
          securityContext:
            privileged: true
          image: josh5/steam-headless:latest   
          command: ["/bin/sh", "-c"]
          args:
            - |
              cp /tmp/init.d/* /etc/cont-init.d/
              exec /entrypoint.sh
          resources:
            requests:
              nvidia.com/gpu: 1 
            limits:
              nvidia.com/gpu: 1 
          volumeMounts:
            - name: home-dir
              mountPath: /home/default/
            - name: games-dir
              mountPath: /mnt/games/
            - name: input-devices
              mountPath: /dev/input/
            - name: dshm
              mountPath: /dev/shm
            - name: config
              mountPath: /tmp/init.d/
          env:
            - name: NAME
              value: 'Homelab Games'
            - name: TZ
              value: 'America/New_York'
            - name: USER_LOCALES
              value: 'en_US.UTF-8 UTF-8'
            - name: DISPLAY
              value: ':55'
            - name: DOCKER_RUNTIME
              value: 'nvidia'
            - name: PUID
              value: '1000'
            - name: PGID
              value: '1000'
            - name: UMASK
              value: '000'
            - name: USER_PASSWORD
              value: 'password'
            - name: MODE
              value: 'primary'
            - name: WEB_UI_MODE
              value: 'none'
            - name: ENABLE_VNC_AUDIO
              value: 'false'
            - name: PORT_NOVNC_WEB
              value: '8083'
            - name: NEKO_NAT1TO1
              value: ''
            - name: ENABLE_SUNSHINE
              value: 'true'
            - name: SUNSHINE_USER
              value: 'sunshine'
            - name: SUNSHINE_PASS
              value: '{{ .Values.sunshine.password }}'
            - name: ENABLE_EVDEV_INPUTS
              value: 'true'
            - name: NVIDIA_DRIVER_CAPABILITIES
              value: 'all'
            - name: NVIDIA_VISIBLE_DEVICES
              value: 'all'
            - name: NVIDIA_DRIVER_VERSION
              value: 580.126.09
      volumes:
        - name: home-dir
          persistentVolumeClaim:
            claimName: home
        - name: games-dir
          persistentVolumeClaim:
            claimName: games
        - name: input-devices
          hostPath:
            path: /dev/input/
        - name: dshm
          emptyDir:
            medium: Memory
        - name: config
          configMap:
            name: sunshine-config
{{- end -}}
