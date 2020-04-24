FROM openvino/ubuntu18_dev:latest

USER root


WORKDIR /home/openvino/workshop

COPY --chown=openvino . /home/openvino/workshop/

RUN ./bootstrap/bootstrap.sh -without-sudo

RUN rm -rf build dist data/public

CMD ["bash", "/home/openvino/workshop/docker-entrypoint.sh"]