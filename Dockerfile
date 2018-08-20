FROM rabbitmq
RUN apt-get update && apt-get install -y curl && \
    apt-get clean
ENV RABBITMQ_USE_LONGNAME=true
ENV RABBITMQ_ERLANG_COOKIE='ReplaceMe'
RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_peer_discovery_aws rabbitmq_web_stomp

ADD definitions.json /etc/rabbitmq/definitions.json
ADD rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
ADD rabbitmq-env.conf /etc/rabbitmq/rabbitmq-env.conf


EXPOSE 15672 5672 4369 25672 15674
