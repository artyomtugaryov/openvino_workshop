# Openvino Workshop

This workshope contains [jupyter notebook](https://jupyter.org/) which describes full [OpenVINO](https://docs.openvinotoolkit.org/) workflow. In this workshop you will try most componrnts of the Openvino Toolkit:
1. [Model Downloader](https://docs.openvinotoolkit.org/latest/_tools_downloader_README.html) - tool that downloads models from Open ModelZoo
2. [Open ModelZoo](https://docs.openvinotoolkit.org/latest/_models_intel_index.html) - set of pre-trained and open-source models that you can use for learning and demo purposes or for developing deep learning software.
3. [Model Optimizer](https://docs.openvinotoolkit.org/latest/_docs_MO_DG_Deep_Learning_Model_Optimizer_DevGuide.html) - tool that facilitates the transition between the training and deployment environment, performs static model analysis, and adjusts deep learning models for optimal execution on end-point target devices.
4. [Inference Engine](https://docs.openvinotoolkit.org/latest/_docs_IE_DG_Deep_Learning_Inference_Engine_DevGuide.html) - a unified API to allow high performance inference on many hardware.
5. [Accuracy Checker](https://docs.openvinotoolkit.org/latest/_tools_accuracy_checker_README.html) - tool to measure accuracy of a model.
6. [Post-Training Optimization Toolkit](https://docs.openvinotoolkit.org/latest/_README.html) - tool designed to convert a model into a more hardware-friendly representation by applying specific methods that do not require re-training, for example, post-training quantization.
7. [Benchmark Application](https://docs.openvinotoolkit.org/latest/_inference_engine_samples_benchmark_app_README.html) - C++ sample for getting best performance with the OpenVINO Inference Engine.
8. [Python API for Inference Engine](https://docs.openvinotoolkit.org/latest/_inference_engine_ie_bridges_python_docs_api_overview.html)


## How to run the workshop

### From Docker

You can find docker image with this notebook by following link: https://hub.docker.com/r/artyomtugaryov/openvino_workshop

To tun this docker use the following link:
```sh
    docker run -p 8888:8888 -it artyomtugaryov/openvino_workshop
```

### From sources
1. [Install OpenVINO](https://docs.openvinotoolkit.org/latest/_docs_install_guides_installing_openvino_linux.html)

2. Run a bootstrap script to install all dependencies and run the jupyter notebook with the workshop:
```bash
    ./bootstrap/bootstrap.sh -start
```
In the successful case you will see the following message:
```bash
    To access the notebook, open this file in a browser:
        file:/.../jupyter/runtime/nbserver-18647-open.html
    Or copy and paste one of these URLs:
        http://localhost:8888/?token=...
     or http://127.0.0.1:8888/?token=...
    Opening in existing browser session.
```

If you get any error, you can setup dependencies manually:

3. Open a terminal and activate OpenVINO environment:

```bash
    source ~/intel/openvino/bin/setupvars.sh
```

4. Clone the repository:

```bash
    git clone https://github.com/artyomtugaryov/openvino_workshop.git
```
5. Change directory to workshop root path:

```bash
    cd openvino_workshop
```

6. Create Virtual environment for python3:

```bash
    python3 -m pip install virtualenv
    
    python3 -m virtualenv -p `which python3` env

    source env/bin/activate
```

7. Install workshop dependencies:

```bash
    pip install -r requirements.txt
```

8. Install OpenVINO python dependencies:

    8.1  Install Accuracy Checker
    ```bash
        pushd ${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/accuracy_checker/
            python setup.py install
        popd
    ```

    8.2 Install Post-Training Optimization Toolkit
    ```bash
        pushd ${INTEL_OPENVINO_DIR}/deployment_tools/tools/post_training_optimization_toolkit/
            python setup.py install
        popd
    ```

    8.3 Install dependencies for the Model Downloader
    ```bash
        python -m pip install -r ${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/downloader/requirements.in
    ```


    8.4 Install dependencies for the Model Optimizer
    ```bash
        python -m pip install -r ${INTEL_OPENVINO_DIR}/deployment_tools/model_optimizer/requirements.txt
    ```

9. Install `gettext-base` package for using envsubst:
```
    apt-get install gettext-base
```

10. Run the notebook:
```bash
   jupyter notebook
```
