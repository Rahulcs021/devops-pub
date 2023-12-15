#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <environment_variables_file>"
  exit 1
fi

env_file="$1"
configmap_name="configmap"
configmap_yaml="configmap.yaml"

# Generate ConfigMap YAML
cat <<EOF > "$configmap_yaml"
apiVersion: v1
kind: ConfigMap
metadata:
  name: $configmap_name
data:
EOF

# Read environment variables from file and append to ConfigMap YAML
while IFS= read -r line; do
  key=$(echo "$line" | cut -d= -f1)
  value=$(echo "$line" | cut -d= -f2-)
  echo "  $key: $value" >> "$configmap_yaml"
done < "$env_file"

echo "ConfigMap YAML file $configmap_yaml created successfully!"
