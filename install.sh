#!/bin/bash

# 检查是否以root权限运行
if [ "$EUID" -ne 0 ]; then 
    echo "请使用sudo运行此安装脚本"
    exit 1
fi

# 复制主脚本到/usr/local/bin/
cp check_urls.sh /usr/local/bin/check-urls

# 设置执行权限
chmod +x /usr/local/bin/check-urls

# 创建全局输出目录
mkdir -p /var/log/check-urls

# 设置目录权限，确保所有用户都可以写入
chmod 777 /var/log/check-urls

echo "安装完成！现在你可以在任何位置使用 'check-urls' 命令" 