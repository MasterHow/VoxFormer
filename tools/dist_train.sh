#!/usr/bin/env bash

# 检查输入参数的数量
if [[ $# -lt 2 ]]; then
    echo "Usage: $0 CONFIG GPUS [OPTIONS...]"
    exit 1
fi

CONFIG=$1
GPUS=$2
PORT=${PORT:-28509}

# 打印用于调试的信息
echo "Config file: $CONFIG"
echo "GPUs: $GPUS"
echo "Port: $PORT"

PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python -m torch.distributed.launch --nproc_per_node=$GPUS --master_port=$PORT \
    $(dirname "$0")/train.py $CONFIG --launcher pytorch "${@:3}" --deterministic
