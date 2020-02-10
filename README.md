# Openvino Workshop

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
    sudo -E apt-get install python3-venv
    
    python3 -m venv env

    source env/bin/activate
```

4. Install OpenVINO python dependencies:

```bash
    # Install Accuracy Checker
    cd ${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/accuracy_checker/
    python setup.py install
    # Install POT
    cd ${INTEL_OPENVINO_DIR}/deployment_tools/tools/post_training_optimization_toolkit
    python setup.py install
    # Install dependencies for the Model Downloader
    cd ${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/downloader/
    pip install -r requirements.in
    # Install dependencies for the Model Optimizer
    cd ${INTEL_OPENVINO_DIR}/deployment_tools/model_optimizer/
    pip install -r requirements.txt
```

5. Install workshop dependencies:

```bash
    pip install -r requirements.txt
```
