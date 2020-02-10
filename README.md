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

5. Install workshop dependencies:

```bash
    pip install -r requirements.txt
```
6. Run the notebook:
```bash
   jupyter notebook
```
