#!/bin/bash

# 修改输出目录为运行脚本的目录下的output-YYYYMMDDHHMMSS
OUTPUT_DIR=$(dirname "$0")/output-$(date +%Y%m%d%H%M%S)

# 检查并创建输出目录
init_output_dirs() {
  if [ ! -d "$OUTPUT_DIR" ]; then
    sudo mkdir -p "$OUTPUT_DIR"
    sudo chmod 777 "$OUTPUT_DIR"
  fi
}

# 检查URL状态码的函数
check_url() {
  local url=$1
  local http_code
  local timestamp

  http_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')

  if [ "$http_code" -ge 200 ] && [ "$http_code" -lt 300 ]; then
    echo -e "\033[32m[${http_code}]\033[0m $url"
    echo "[$timestamp] $url - HTTP状态码: $http_code" >>"$OUTPUT_DIR/$http_code.log"
    return 0
  elif [ "$http_code" -ge 300 ] && [ "$http_code" -lt 400 ]; then
    echo -e "\033[33m[${http_code}]\033[0m $url"
    echo "[$timestamp] $url - HTTP状态码: $http_code" >>"$OUTPUT_DIR/$http_code.log"
    return 1
  else
    echo -e "\033[31m[${http_code}]\033[0m $url"
    echo "[$timestamp] $url - HTTP状态码: $http_code" >>"$OUTPUT_DIR/$http_code.log"
    return 2
  fi
}

# 主程序
main() {
  # 初始化输出目录
  init_output_dirs

  # 检查参数
  if [ $# -eq 0 ]; then
    echo "使用方法: $0 urls.txt"
    echo "urls.txt 应包含每行一个URL"
    exit 1
  fi

  # 检查文件是否存在
  if [ ! -f "$1" ]; then
    echo "错误: 文件 '$1' 不存在"
    exit 1
  fi

  # 计数器
  local total=0

  # 读取文件中的每个URL并检查
  echo "开始检查URL..."
  echo "------------------------"

  while IFS= read -r url || [ -n "$url" ]; do
    # 跳过空行和注释行
    [[ -z "$url" || "$url" =~ ^#.*$ ]] && continue

    ((total++))
    check_url "$url"

  done <"$1"

  # 输出统计信息
  echo "------------------------"
  echo "检查完成!"
  echo "总计: $total"
}

# 运行主程序
main "$@"
