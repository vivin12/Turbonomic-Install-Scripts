#!/bin/bash

# Prompt for IBM Cloud Container Registry (ICR) credentials
read -p "Enter your IBM Cloud API Key: " IBM_CLOUD_API_KEY
echo

# Log in to IBM ICR using the API key
echo "$IBM_CLOUD_API_KEY" | podman login -u iamapikey --password-stdin icr.io
if [ $? -ne 0 ]; then
    echo "IBM ICR login failed. Please check your API key."
    exit 1
fi

# Prompt for Private Registry credentials
read -p "Enter your Private Registry URL (e.g., registry.example.com): " PRIVATE_REGISTRY
read -p "Enter your Private Registry username: " PRIVATE_REGISTRY_USERNAME
read -sp "Enter your Private Registry password: " PRIVATE_REGISTRY_PASSWORD
echo

# Log in to Private Registry
echo "$PRIVATE_REGISTRY_PASSWORD" | podman login -u "$PRIVATE_REGISTRY_USERNAME" --password-stdin "$PRIVATE_REGISTRY"
if [ $? -ne 0 ]; then
    echo "Private Registry login failed. Please check your credentials."
    exit 1
fi

# List of Turbonomic images and their versions
IMAGES=(
    "action-orchestrator:8.15.4"
    "api:8.15.4"
    "auth:8.15.4"
    "cloud-optimizer:8.15.4"
    "clustermgr:8.15.4"
    "consul:8.15.4"
    "cost:8.15.4"
    "group:8.15.4"
    "history:8.15.4"
    "kafka:8.15.4"
    "kube-state-metrics:2.14.0"
    "market:8.15.4"
    "metadata:8.15.4"
    "nginx:8.15.4"
    "plan-orchestrator:8.15.4"
    "prometheus:2.54.1"
    "prometheus-config-manager:8.15.4"
    "prometheus-kafka-adapter:1.8.0.10"
    "redis:6.1.209.1"
    "repository:8.15.4"
    "rsyslog:8.15.4"
    "server-power-modeler:8.15.4"
    "suspend:8.15.4"
    "topology-processor:8.15.4"
    "ui:8.15.4"
    "zookeeper:8.15.4"
    "diags-anonymizer:8.15.4"
    "oauth2:8.15.4"
    "ibm-licensing-operator:1.16.6"
    "ibm-licensing:1.16.6"
    "configmap-reload:0.13.1"
    "node-exporter:1.8.2"
    "mysqld-exporter:0.14.0.12"
    "redis_exporter:1.67.0"
    # Add other images as needed
)

# Loop through the images: pull from source, tag, and push to target
for IMAGE in "${IMAGES[@]}"; do
    SOURCE_IMAGE="icr.io/cpopen/turbonomic/$IMAGE"
    TARGET_IMAGE="$PRIVATE_REGISTRY/$IMAGE"

    echo "Processing $IMAGE..."

    # Pull the image from IBM ICR
    if ! podman pull "$SOURCE_IMAGE"; then
        echo "Failed to pull $SOURCE_IMAGE"
        continue
    fi

    # Tag the image for the private registry
    if ! podman tag "$SOURCE_IMAGE" "$TARGET_IMAGE"; then
        echo "Failed to tag $SOURCE_IMAGE as $TARGET_IMAGE"
        continue
    fi

    # Push the image to the private registry
    if ! podman push "$TARGET_IMAGE"; then
        echo "Failed to push $TARGET_IMAGE"
        continue
    fi

    echo "$IMAGE processed successfully."
done

echo "All images have been processed."
