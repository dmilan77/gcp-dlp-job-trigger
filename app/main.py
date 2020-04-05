#!/usr/bin/env python


import os

# [START pubsub_quickstart_sub_deps]
from google.cloud import pubsub_v1
from google.cloud import dlp
from google.cloud import storage
from google.cloud import pubsub

# ----------------------------
#  User-configurable Constants

# Initialize the Google Cloud client libraries
dlp = dlp.DlpServiceClient()

"""The infoTypes of information to match"""
"""For more info visit: https://cloud.google.com/dlp/docs/concepts-infotypes"""
INFO_TYPES = [
    'FIRST_NAME', 'PHONE_NUMBER', 'EMAIL_ADDRESS', 'US_SOCIAL_SECURITY_NUMBER'
]


PROJECT_ID = 'data-protection-01'
# PUB_SUB_TOPIC = 'projects/data-protection-01/topics/dlp-result-topic-cust01'

PUB_SUB_TOPIC = 'dlp-result-topic-cust01'
STAGING_BUCKET = 'dlp-quarantine-bucket-cust01'
MIN_LIKELIHOOD = 'POSSIBLE'
MAX_FINDINGS = 0

def sub(subscription_name):
    """Receives messages from a Pub/Sub subscription."""
    # [START pubsub_quickstart_sub_client]
    # Initialize a Subscriber client
    client = pubsub_v1.SubscriberClient()
    # [END pubsub_quickstart_sub_client]
    # Create a fully qualified identifier in the form of
    # `projects/{project_id}/subscriptions/{subscription_name}`
    # subscription_path = client.subscription_path(project_id, subscription_name)
    subscription_path = subscription_name

    def callback(message):
        print(
            "Received message {} of message ID {}\n".format(
                message, message.message_id
            )
        )
        # Creating DLP Job
        create_DLP_job(message.attributes)
        # Acknowledge the message. Unack'ed messages will be redelivered.
        message.ack()
        print("Acknowledged message {}\n".format(message.message_id))

    streaming_pull_future = client.subscribe(
        subscription_path, callback=callback
    )
    print("Listening for messages on {}..\n".format(subscription_path))

    # Calling result() on StreamingPullFuture keeps the main thread from
    # exiting while messages get processed in the callbacks.
    try:
        streaming_pull_future.result()
    except:  # noqa
        streaming_pull_future.cancel()


# def create_DLP_job(data, done):


def create_DLP_job(data):

  """This function is triggered by new files uploaded to the designated Cloud Storage quarantine/staging bucket.
       It creates a dlp job for the uploaded file.
    Arg:
       data: The Cloud Storage Event
    Returns:
        None. Debug information is printed to the log.
    """



  # Get the targeted file in the quarantine bucket

  file_name = data['name']
  print('Function triggered for file [{}]'.format(file_name))

  # Prepare info_types by converting the list of strings (INFO_TYPES) into a list of dictionaries
  info_types = [{'name': info_type} for info_type in INFO_TYPES]

  # Convert the project id into a full resource id.
  parent = dlp.project_path(PROJECT_ID)

  # Construct the configuration dictionary.
  inspect_job = {
      'inspect_config': {
          'info_types': info_types,
          'min_likelihood': MIN_LIKELIHOOD,
          'limits': {
              'max_findings_per_request': MAX_FINDINGS
          },
      },
      'storage_config': {
          'cloud_storage_options': {
              'file_set': {
                  'url':
                      'gs://{bucket_name}/{file_name}'.format(
                          bucket_name=STAGING_BUCKET, file_name=file_name)
              }
          }
      },
      'actions': [{
          'pub_sub': {
              'topic':
                  'projects/{project_id}/topics/{topic_id}'.format(
                      project_id=PROJECT_ID, topic_id=PUB_SUB_TOPIC)
          }
      }]
  }

  # Create the DLP job and let the DLP api processes it.
  try:
    dlp.create_dlp_job(parent, inspect_job)
    print('Job created by create_DLP_job')
  except Exception as e:
    print(e)





if __name__ == "__main__":
    SUBSCRIPTION_NAME = os.environ.get('SUBSCRIPTION_NAME')
    sub( SUBSCRIPTION_NAME)
# [END pubsub_quickstart_sub_all]

