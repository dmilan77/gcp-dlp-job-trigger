#!/bin/bash
export SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${SCRIPTDIR}/init.sh

source ${SCRIPTDIR}/build.sh
source ${SCRIPTDIR}/del-container.sh
source ${SCRIPTDIR}/run.sh
source ${SCRIPTDIR}/logs.sh
