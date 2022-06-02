FROM rabbitmq:3.7.9-management-alpine

RUN rabbitmq-plugins enable rabbitmq_stomp
RUN rabbitmq-plugins enable rabbitmq_web_stomp
RUN rabbitmq-plugins enable --offline rabbitmq_management

ENV RABBITMQ_DEFAULT_USER usuario123
ENV RABBITMQ_DEFAULT_PASS senha123

EXPOSE 61613
EXPOSE 15674
EXPOSE 15672
EXPOSE 5672