#!/bin/bash
set -e

if [ -z "$CHART_FOLDER" ]; then
  echo "CHART_FOLDER is not set. Quitting."
  exit 1
fi

if [ -z "$CHARTREPOSITORY_URL" ]; then
  echo "$CHARTREPOSITORY_URL is not set. Quitting."
  exit 1
fi

if [ -z "$FORCE" ]; then
  FORCE=""
elif [ "$FORCE" == "1" ] || [ "$FORCE" == "True" ] || [ "$FORCE" == "TRUE" ]; then
  FORCE="-f"
fi

cd "${SOURCE_DIR}/${CHART_FOLDER}"

helm init --client-only

helm inspect chart .

helm package .

helm chart push "${CHART_FOLDER}-*" "$CHARTREPOSITORY_URL" -u "$HELM_REPO_PASSWORD" -p "$HELM_REPO_PASSWORD" ${FORCE}