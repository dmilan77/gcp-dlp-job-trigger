FROM python:3.7

MAINTAINER Milan Das "milan.das77@gmail.com"

#ENV SUBSCRIPTION_NAME="projects/data-protection-01/subscriptions/dlp-quarantine-subscription-cust01"
ENV GOOGLE_APPLICATION_CREDENTIALS="/securekey/gcp_service_acount_key.json"

ENV APP_HOME /dockerapp

COPY requirements.txt $APP_HOME/
WORKDIR $APP_HOME
RUN pip install -r requirements.txt
COPY ./app/ $APP_HOME/app/
ENV PYTHONPATH=$PYTHONPATH:$APP_HOME

CMD ["python","-u","app/main.py"]
