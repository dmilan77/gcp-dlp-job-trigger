#!/bin/bash
export SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${SCRIPTDIR}/init.sh
docker logs  ${CONTAINER_NAME} --follow
