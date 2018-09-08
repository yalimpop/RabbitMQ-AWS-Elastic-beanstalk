FROM rabbitmq
RUN apt-get update && apt-get install -y curl && \
    apt-get clean && apt-get install -y unzip && \
    apt-get install -y libwww-perl libdatetime-perl

RUN curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O && \
    unzip CloudWatchMonitoringScripts-1.2.2.zip && \
    rm CloudWatchMonitoringScripts-1.2.2.zip && \
    cd aws-scripts-mon

RUN printf "AWSAccessKeyId=${AWS_ACCESS_KEY_ID}\nAWSSecretKey=${AWS_SECRET_KEY}" >> /aws-scripts-mon/awscreds.conf

#RUN ls ./aws-scripts-mon

#RUN cat ./aws-scripts-mon/awscreds.conf

RUN echo "1 * * * * ~/aws-scripts-mon/mon-put-instance-data.pl --mem-used-incl-cache-buff --mem-util --mem-used --mem-avail --disk-space-util --memory-units=megabytes --disk-path=/ --from-cron" >> /etc/crontab

#RUN cat /etc/crontab

#RUN ./aws-scripts-mon/mon-put-instance-data.pl --mem-util --verify --verbose

ENV RABBITMQ_USE_LONGNAME=true
ENV RABBITMQ_ERLANG_COOKIE='Mimikyu'

RUN rabbitmq-plugins enable rabbitmq_management 
RUN rabbitmq-plugins enable rabbitmq_peer_discovery_aws
RUN rabbitmq-plugins enable rabbitmq_web_mqtt

ADD definitions.json /etc/rabbitmq/definitions.json
ADD rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
ADD rabbitmq-env.conf /etc/rabbitmq/rabbitmq-env.conf

EXPOSE 15672 5672 4369 25672 15675
