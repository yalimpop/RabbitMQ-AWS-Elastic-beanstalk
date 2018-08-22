FROM rabbitmq:3.7.7-management
RUN apt-get update && apt-get install -y curl && \
    apt-get clean
ENV RABBITMQ_USE_LONGNAME=true
ENV RABBITMQ_ERLANG_COOKIE='Mimikyu'

ADD enabled_plugins /etc/rabbitmq/enabled_plugins

RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_peer_discovery_aws rabbitmq_web_mqtt rabbitmq_web_stomp

ADD definitions.json /etc/rabbitmq/definitions.json
ADD rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
ADD rabbitmq-env.conf /etc/rabbitmq/rabbitmq-env.conf

RUN rabbitmqctl stop_app
RUN rabbitmqctl start_app

EXPOSE 15672 5672 4369 25672 15674 15675
