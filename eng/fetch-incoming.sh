#!/bin/bash
set -euo pipefail

[[ -n ${GITHUB_TOKEN} &&  -n ${DISPATCH_PAYLOAD} ]]

mkdir -p incoming

REPO=$(jq -r ".repo" <<< $DISPATCH_PAYLOAD)
RUN_ID=$(jq -r ".run_id" <<< $DISPATCH_PAYLOAD)

IFS=/ read REPO_OWNER REPO_NAME <<< ${REPO}

ARTIFACT_ID=$(./ok.sh list_workflow_run_artifacts "${REPO_OWNER}" "${REPO_NAME}" "${RUN_ID}" \
    | awk '($2 == "signed"){ print $1 }')

if [[ -z $ARTIFACT_ID ]]; then
    echo "Could not locate 'signed' artifact for run '${RUN_ID}' in '${REPO}'."
    exit 1
fi

./ok.sh download_workflow_run_artifact "${REPO_OWNER}" "${REPO_NAME}" "${ARTIFACT_ID}" > signed.zip
unzip signed.zip -d incoming
