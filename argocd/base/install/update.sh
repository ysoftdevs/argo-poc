#!/usr/bin/env sh

set -e

VERSION=$1
if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version>"
  echo "Example: $0 v3.0.0-rc4"
  exit 1
fi

URL="https://raw.githubusercontent.com/argoproj/argo-cd/$VERSION/manifests/install.yaml"

echo "Downloading ArgoCD version $VERSION from $URL"

cat >argocd.yaml <<EOF
# Source:
# $URL
# To update, use ./update.sh <version>

EOF

if ! curl -sS -f -o - $URL >> argocd.yaml; then
  echo "Error: Failed to download ArgoCD version $VERSION"
  exit 1
fi