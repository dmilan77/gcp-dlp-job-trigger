#!/bin/bash

# source ~/.init-gcp
export CUSTOMER_NAME=cust01
export BUCKET_LOCATION=US-EAST1


{
    export PREFIX=dlp-quarantine
    export QUARANTINE_BUCKET=${PREFIX}-bucket-${CUSTOMER_NAME}
    export QUARANTINE_TOPIC=${PREFIX}-topic-${CUSTOMER_NAME}
    export QUARANTINE_SUBSCRIPTION=${PREFIX}-subscription-${CUSTOMER_NAME}
    gsutil mb -l ${BUCKET_LOCATION} -b on gs://${QUARANTINE_BUCKET} 
    gcloud pubsub topics create ${QUARANTINE_TOPIC}
    gsutil notification create -t ${QUARANTINE_TOPIC} -f json gs://${QUARANTINE_BUCKET}
    gcloud pubsub subscriptions create ${QUARANTINE_SUBSCRIPTION} --topic ${QUARANTINE_TOPIC}
}



{
    export PREFIX=dlp-sensitive
    export SENSITIVE_DATA_BUCKET=${PREFIX}-bucket-${CUSTOMER_NAME}
    export SENSITIVE_TOPIC=${PREFIX}-topic-${CUSTOMER_NAME}
    export SENSITIVE_SUBSCRIPTION=${PREFIX}-subscription-${CUSTOMER_NAME}
    gsutil mb  -l ${BUCKET_LOCATION} -b on gs://${SENSITIVE_DATA_BUCKET}
    gcloud pubsub topics create ${SENSITIVE_TOPIC}
    gsutil notification create -t ${SENSITIVE_TOPIC} -f json gs://${SENSITIVE_DATA_BUCKET}
    gcloud pubsub subscriptions create ${SENSITIVE_SUBSCRIPTION} --topic ${SENSITIVE_TOPIC}
}


{
    export PREFIX=dlp-nonsensitive
    export NON_SENSITIVE_DATA_BUCKET=${PREFIX}-bucket-${CUSTOMER_NAME}
    export NON_SENSITIVE_TOPIC=${PREFIX}-topic-${CUSTOMER_NAME}
    export NON_SENSITIVE_SUBSCRIPTION=${PREFIX}-subscription-${CUSTOMER_NAME}
    gsutil mb  -l ${BUCKET_LOCATION} -b on gs://${NON_SENSITIVE_DATA_BUCKET} 
    gcloud pubsub topics create ${NON_SENSITIVE_TOPIC}
    gsutil notification create -t ${NON_SENSITIVE_TOPIC} -f json gs://${NON_SENSITIVE_DATA_BUCKET}
    gcloud pubsub subscriptions create ${NON_SENSITIVE_SUBSCRIPTION} --topic ${NON_SENSITIVE_TOPIC}
}


{
    export PREFIX=dlp-result
    # export DLP_RESULT_DATA_BUCKET=${PREFIX}-bucket-${CUSTOMER_NAME}
    export DLP_RESULT_TOPIC=${PREFIX}-topic-${CUSTOMER_NAME}
    # export DLP_RESULT_SUBSCRIPTION=${PREFIX}-subscription-${CUSTOMER_NAME}
    # gsutil mb  -l ${BUCKET_LOCATION} -b on gs://${DLP_RESULT_DATA_BUCKET} 
    gcloud pubsub topics create ${DLP_RESULT_TOPIC}
    # gsutil notification create -t ${DLP_RESULT_TOPIC} -f json gs://${DLP_RESULT_DATA_BUCKET}
    # gcloud pubsub subscriptions create ${DLP_RESULT_SUBSCRIPTION} --topic ${DLP_RESULT_TOPIC}
}












