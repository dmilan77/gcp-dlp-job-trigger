#!/bin/bash
export CUSTOMER_NAME=cust01
export BUCKET_LOCATION=US-EAST1
 export PREFIX=dlp-quarantine
 export QUARANTINE_BUCKET=${PREFIX}-bucket-${CUSTOMER_NAME}
gsutil -m  cp *sample-file/* gs://${QUARANTINE_BUCKET}/
