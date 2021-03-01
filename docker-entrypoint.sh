source /opt/intel/openvino_2021/bin/setupvars.sh 
PATH=${HOME}/.local/bin:${PATH} jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root