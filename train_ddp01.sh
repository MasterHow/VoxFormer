#!/bin/bash
source /opt/conda/bin/activate
conda create -n open-mmlab python=3.8 -y
conda activate open-mmlab
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/
export CC=gcc
export CXX=g++
export CUDA_HOME=/usr/local/cuda-11.1
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
cd /workspace/mnt/storage/shihao/MyCode-02/VoxFormer
pip install --no-index --find-links=/workspace/mnt/storage/shihao/MyCode-02/VoxFormer/pip_packages torch==1.9.1+cu111 torchvision==0.10.1+cu111 torchaudio==0.9.1
conda install -c omgarcia gcc-6 -y
pip install openmim
mim install mmcv-full==1.4.0
pip install mmdet==2.14.0
pip install mmsegmentation==0.14.1
cd /workspace/mnt/storage/shihao/MyCode-02/mmdet3d
git reset --hard HEAD
git checkout v0.17.1
pip install -v -e .
MMENGINE_LITE=1 pip install mmengine
pip install yapf==0.40.1
pip install timm
cd /workspace/mnt/storage/shihao/MyCode-02/VoxFormer/deform_attn_3d
python setup.py build_ext --inplace
pip install einops
pip install seaborn
pip install numpy==1.19.5
pip install setuptools==59.5.0
cd /workspace/mnt/storage/shihao/MyCode-02/VoxFormer
chmod 777 ./tools/dist_train.sh
bash ./tools/dist_train.sh ./projects/configs/voxformer/voxformer_mm-T_3D_event.py 8