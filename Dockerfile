FROM rabbitmq:3.7.7
RUN apt-get update && apt-get install -y curl && \
    apt-get clean
ENV RABBITMQ_USE_LONGNAME=true
ENV RABBITMQ_ERLANG_COOKIE='Mimikyu'

RUN rabbitmq-plugins enable --offline rabbitmq_management
RUN rabbitmq-plugins enable --offline rabbitmq_peer_discovery_aws
RUN rabbitmq-plugins enable --online rabbitmq_web_stomp
RUN rabbitmq-plugins enable --online rabbitmq_web_mqtt

ADD definitions.json /etc/rabbitmq/definitions.json
ADD rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
ADD rabbitmq-env.conf /etc/rabbitmq/rabbitmq-env.conf

RUN rabbitmq-plugins list -e rabbit

EXPOSE 15672 5672 4369 25672 15674 15675
