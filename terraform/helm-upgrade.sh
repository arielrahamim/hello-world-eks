#!/bin/bash

KUBECONFIG_FILE="$KUBECONFIG"
VALUES_FILE="$VALUES_FILE"
RELEASE_NAME="$RELEASE_NAME"
NAMESPACE="$NAMESPACE"

# Check if required variables are set
if [ -z "$KUBECONFIG_FILE" ]  [ -z "$VALUES_FILE" ] [ -z "$RELEASE_NAME" ]  [ -z "$NAMESPACE" ]; then
  echo "Usage: $0 -k=<kubeconfig_file> -f=<values_file> -c=<chart_path> -r=<release_name> -n=<namespace>"
  exit 1
fi

helm repo add https://kubernetes.github.io/ingress-nginx
helm upgrade -i "$RELEASE_NAME" -f <(echo "$VALUES_FILE") -n "$NAMESPACE" --kubeconfig "$KUBECONFIG_FILE" --create-namespace --wait --dependency-update
