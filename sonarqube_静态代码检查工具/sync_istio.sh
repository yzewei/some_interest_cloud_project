#!/bin/bash

# 定义本地目标目录
local_dir="code"

# 判断本地目录是否存在
if [! -d "$local_dir" ]; then
    # 如果不存在，则执行git clone操作
    git clone https://github.com/istio/istio.git "$local_dir"
else
    # 如果存在，进入该目录并执行git pull来更新
    cd "$local_dir"
    git pull
fi
