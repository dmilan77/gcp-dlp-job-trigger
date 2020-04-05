#!/bin/bash
export SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${SCRIPTDIR}/init.sh


docker run -d \
    --name ${CONTAINER_NAME} \
    -v ${SECURE_KEY_HOST_PATH}:/securekey \
    -e PROJECT_ID=${PROJECT_ID} \
    -e SUBSCRIPTION_NAME=${SUBSCRIPTION_NAME} \
    -e DLP_ACTION_TOPIC=${DLP_ACTION_TOPIC} \
    -e MIN_LIKELIHOOD=${MIN_LIKELIHOOD} \
    -e MAX_FINDINGS=${MAX_FINDINGS} \
    ${REPO_NAME}
