{{- define "dev.pitlor.homelab.open-archiver.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: open-archiver
  namespace: open-archiver
spec:
  selector:
    app: open-archiver
  ports:
    - protocol: TCP
      port: 3000
      targetPort: 3000
  type: ClusterIP
---
apiVersion: v1
kind: Service
metadata:
  name: valkey
  namespace: open-archiver
spec:
  selector:
    app: valkey
  ports:
    - protocol: TCP
      port: 6379
      targetPort: 6379
  type: ClusterIP
---
apiVersion: v1
kind: Service
metadata:
  name: meilisearch
  namespace: open-archiver
spec:
  selector:
    app: meilisearch
  ports:
    - protocol: TCP
      port: 7700
      targetPort: 7700
  type: ClusterIP
---
apiVersion: v1
kind: Service
metadata:
  name: tika
  namespace: open-archiver
spec:
  selector:
    app: tika
  ports:
    - protocol: TCP
      port: 9998
      targetPort: 9998
  type: ClusterIP
{{- end -}}
