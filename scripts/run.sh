#!/bin/bash
export SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${SCRIPTDIR}/init.sh

docker run -d \
    --name ${CONTAINER_NAME} \
    -v ${SECURE_KEY_HOST_PATH}:/securekey \
    -e SUBSCRIPTION_NAME=${SUBSCRIPTION_NAME} \
    ${REPO_NAME}
