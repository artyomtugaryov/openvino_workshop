# Openvino Workshop

This workshope contains [jupyter notebook](https://jupyter.org/) which describes full [OpenVINO](https://docs.openvinotoolkit.org/) workflow. In this workshop you will try most componrnts of the Openvino Toolkit:
1. [Model Downloader](https://docs.openvinotoolkit.org/latest/_tools_downloader_README.html)
2. [Open ModelZoo](https://docs.openvinotoolkit.org/latest/_models_intel_index.html)
3. [Model Optimizer](https://docs.openvinotoolkit.org/latest/_docs_MO_DG_Deep_Learning_Model_Optimizer_DevGuide.html)
4. [Inference Engine](https://docs.openvinotoolkit.org/latest/_docs_IE_DG_Deep_Learning_Inference_Engine_DevGuide.html)
5. [Accuracy Checker](https://docs.openvinotoolkit.org/latest/_tools_accuracy_checker_README.html)
6. [Post-Training Optimization Toolkit](https://docs.openvinotoolkit.org/latest/_README.html)
7. [Benchmark Application](https://docs.openvinotoolkit.org/latest/_inference_engine_samples_benchmark_app_README.html)
8. [Python API for Inference Engine](https://docs.openvinotoolkit.org/latest/_inference_engine_ie_bridges_python_docs_api_overview.html)


## How to run the workshop

1. Install OpenVINO and activate environment:

```bash
    source ~/intel/openvino/bin/setupvars.sh
```

2. Clone the repository

```bash
    git clone https://github.com/artyomtugaryov/openvino_workshop.git
```

3. Create Virtual environment for python3:

```bash
    python3 -m pip install virtualenv
    
    python3 -m virtualenv -p `which python3` env

    source env/bin/activate
```

4. Install workshop dependencies:

```bash
    pip install -r requirements.txt
```

5. Install OpenVINO python dependencies:

    4.1  Install Accuracy Checker
    ```bash
        cd ${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/accuracy_checker/
        python setup.py install
    ```

    4.2 Install Post-Training Optimization Toolkit
    ```bash
        cd ${INTEL_OPENVINO_DIR}/deployment_tools/tools/post_training_optimization_toolkit
        python setup.py install
    ```

    4.3 Install dependencies for the Model Downloader
    ```bash
        pip install -r ${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/downloader/requirements.in
    ```


    4.4 Install dependencies for the Model Optimizer
    ```bash
        pip install -r ${INTEL_OPENVINO_DIR}/deployment_tools/model_optimizer/requirements.txt
    ```

6. Install `gettext-base` package for using envsubst:

```
    apt-get install gettext-base
```

7. Run the notebook:
```bash
   cd <OPENVINO_WORKSHOP_ROOT_PATH>
   jupyter notebook
```
