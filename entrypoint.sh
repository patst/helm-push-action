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

helm inspect chart .

helm repo add chartmuseum "$CHARTREPOSITORY_URL"
helm-push ./ chartmuseum "$FORCE"