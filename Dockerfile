FROM openvino/ubuntu18_dev_no_samples:latest

USER root

RUN apt update && apt install gettext-base

WORKDIR ${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/accuracy_checker

RUN python3 setup.py install && \
    rm -rf accuracy_checker.egg-info build dist data/public

WORKDIR ${INTEL_OPENVINO_DIR}/deployment_tools/tools/post_training_optimization_toolkit
RUN python3 setup.py install

WORKDIR /home/openvino/workshop/

COPY --chown=openvino data /home/openvino/workshop/data
COPY --chown=openvino pictures /home/openvino/workshop/pictures
COPY --chown=openvino practice /home/openvino/workshop/practice
COPY --chown=openvino docker-entrypoint.sh /home/openvino/workshop/docker-entrypoint.sh
COPY --chown=openvino OpenVINO_Workshop.ipynb /home/openvino/workshop/OpenVINO_Workshop.ipynb
COPY --chown=openvino requirements.txt /home/openvino/workshop/requirements.txt
COPY --chown=openvino utils.py /home/openvino/workshop/utils.py

RUN ${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/downloader/downloader.py --name ssd_mobilenet_v2_coco -o data/
RUN ${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/downloader/converter.py --name ssd_mobilenet_v2_coco -d data/public/ssd_mobilenet_v2_coco/data/ --precisions FP16
RUN mv ./data/public/ssd_mobilenet_v2_coco/data/public/ssd_mobilenet_v2_coco/FP16/*xml ./data/model.xml && mv ./data/public/ssd_mobilenet_v2_coco/data/public/ssd_mobilenet_v2_coco/FP16/*bin ./data/model.bin
RUN rm -rf build dist data/public

RUN python3 -m pip install -r requirements.txt

CMD ["bash", "/home/openvino/workshop/docker-entrypoint.sh"]