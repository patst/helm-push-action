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

# debug outout
ls -la
env
ls -la "${SOURCE_DIR}"
ls -la "${GITHUB_WORKSPACE}"

sleep 7200

cd "${GITHUB_WORKSPACE}/${SOURCE_DIR}/${CHART_FOLDER}"

helm inspect chart .

helm repo add chartmuseum "$CHARTREPOSITORY_URL"
helm push ./ chartmuseum "$FORCE"