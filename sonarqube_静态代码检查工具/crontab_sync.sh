#!/bin/bash

# 设置 crontab 任务，每小时执行一次 sync_istio.sh 脚本 需要修改路径
CRON_TASK="0 * * * * sync_istio.sh"
if [[ $CRON_TASK == "0 * * * * sync_istio.sh" ]]; then
	echo "需要修改路径！"
	exit 1
fi
CRON_COMMAND="(crontab -l 2>/dev/null; echo \"$CRON_TASK\") | crontab -"

# 执行 crontab 命令并获取返回值
if eval $CRON_COMMAND; then
    echo "执行成功"
else
    echo "执行失败"
    # 检查 crontab 命令的错误信息
    if [ $? -eq 1 ]; then
        echo "可能是 crontab 语法错误或权限不足"
    elif [ $? -eq 2 ]; then
        echo "可能是 sync_istio.sh 脚本路径错误或脚本不存在"
    else
        echo "未知错误"
    fi
fi
