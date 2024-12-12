#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
    echo "请使用sudo运行此卸载脚本"
    exit 1
fi

# 删除程序
rm -f /usr/local/bin/check-urls

# 删除日志目录
rm -rf /var/log/check-urls

echo "卸载完成！" 