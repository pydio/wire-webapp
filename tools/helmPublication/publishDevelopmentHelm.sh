#!/usr/bin/env bash

set -euo pipefail

: "${CHART_REPOSITORY_NAME:?CHART_REPOSITORY_NAME is required}"
: "${CHART_REPOSITORY_URL:?CHART_REPOSITORY_URL is required}"
: "${HELM_CHART_VERSION:?HELM_CHART_VERSION is required}"

helm plugin install https://github.com/hypnoglow/helm-s3.git --version 0.15.1
helm repo add "${CHART_REPOSITORY_NAME}" "${CHART_REPOSITORY_URL}"
helm repo update

published_count="$(
  helm search repo "${CHART_REPOSITORY_NAME}/webapp" --devel --versions --output json |
    jq --arg chart_version "${HELM_CHART_VERSION}" '[.[] | select(.version == $chart_version)] | length'
)"

if [[ "${published_count}" -gt 0 ]]; then
  echo "Reusing existing Helm chart version ${HELM_CHART_VERSION}."
else
  CHART_VERSION="${HELM_CHART_VERSION}" \
    yq -i '.version = strenv(CHART_VERSION) | .appVersion = strenv(CHART_VERSION)' charts/webapp/Chart.yaml
  chart_package_directory="${RUNNER_TEMP}/development-webapp-chart"
  mkdir -p "${chart_package_directory}"
  helm package ./charts/webapp --destination "${chart_package_directory}"
  helm s3 push --relative "${chart_package_directory}/webapp-${HELM_CHART_VERSION}.tgz" "${CHART_REPOSITORY_NAME}"
fi

helm repo update
helm search repo "${CHART_REPOSITORY_NAME}/webapp" --devel --versions --output json |
  jq -e --arg chart_version "${HELM_CHART_VERSION}" \
    '[.[] | select(.version == $chart_version and .app_version == $chart_version)] | length == 1' >/dev/null

echo "helm_chart_version=${HELM_CHART_VERSION}" >> "${GITHUB_OUTPUT}"
