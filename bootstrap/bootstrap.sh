#!/bin/bash

while test $# -gt 0; do
    case "$1" in
        -start)
            shift
            START=1
            ;;
        *)
            echo "Unsupported argument: $1"
            exit -1
            ;;
    esac
done

set -e

echo "Activate OpenVINO environment"
source ${INTEL_OPENVINO_DIR:-~/intel/openvino_2021}/bin/setupvars.sh

echo "Install 'gettext-base' package for using envsubst"
sudo -E apt update && sudo apt install gettext-base

echo "Create python virtual environment"
python3 -m pip install virtualenv

python3 -m virtualenv -p `which python3` python_environment

source python_environment/bin/activate

echo "Install Accuracy Checker"
pushd ${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/accuracy_checker
    python3 setup.py install
    
    echo "Cleanup"
    rm -rf accuracy_checker.egg-info build dist data/public
popd

echo "Install Post-Training Optimization Toolkit"
pushd ${INTEL_OPENVINO_DIR}/deployment_tools/tools/post_training_optimization_toolkit
    python3 setup.py install
popd

echo "Install dependencies for the Model Downloader"
python3 -m pip install -r "${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/downloader/requirements.in"

echo "Install dependencies for the Model Optimizer"
python3 -m pip install -r "${INTEL_OPENVINO_DIR}/deployment_tools/model_optimizer/requirements.txt"

echo "Donload model ssd_mobilenet_v2_coco"
${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/downloader/downloader.py --name ssd_mobilenet_v2_coco -o data/
${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/downloader/converter.py --name ssd_mobilenet_v2_coco -d data/ --precisions FP16
mv ./data/public/ssd_mobilenet_v2_coco/FP16/*xml ./data/model.xml
mv ./data/public/ssd_mobilenet_v2_coco/FP16/*bin ./data/model.bin

echo "Install workshop dependencies"
python3 -m pip install -r requirements.txt

if [ -n "${START}" ]; then
    echo "Start jupyter notebook"
    jupyter notebook
fi