#!/bin/bash
# Usage: ./disaster_recovery.sh <old backup id> <backup time (optional)>

# Set some variables
version=$(kubectl get -n homelab HelmChart homelab-chart -o=jsonpath='{.spec.version}')
valuesFile=$(mktemp)
recoverFromBackupId=$1
recoverFromBackupTime=$2
newBackupId=$(date +%F)

# Save initial values to temp file
kubectl get -n homelab HelmChart homelab-chart -o=jsonpath='{.spec.valuesContent}' > $valuesFile

# First we need to tell Velero to update
yq e -i ".velero.restore = true | .velero.version = .velero.version + 1" $valuesFile

# Then, adjust backup IDs
applications=("grafana" "vaultwarden" "immich" "nextcloud" "blueskyPds" "guacamole")
for application in "${applications[@]}"; do
  yq e -i ".postgres.$application.backupId = \"$newBackupId\" | .postgres.$application.recoverFromBackupId = \"$recoverFromBackupId\"" $valuesFile
  
  if [[ -n $recoverFromBackupTime ]]; then
    yq e -i ".postgres.$application.recoverFromBackupTime = \"$recoverFromBackupTime\"" $valuesFile
  fi
done

# Create a base k8s config
cat > disaster_recovery.yaml <<"EOF"
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: homelab-chart
  namespace: homelab
spec:
  chart: oci://us-central1-docker.pkg.dev/dev-pitlor-homelab/homelab-chart/homelab-containers
  targetNamespace: homelab
EOF

# Remember the version and apply
valuesContent=$(cat $valuesFile)
yq e -i ".spec.valuesContent = \"${valuesContent//\"/\\\"}\" | .spec.version = \"$version\"" disaster_recovery.yaml
kubectl apply -f disaster_recovery.yaml
rm $valuesFile