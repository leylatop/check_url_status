# #!/bin/bash

# # 检查URL状态码的函数
# check_url() {
#     local url=$1
#     local http_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

#     if [ "$http_code" = "200" ]; then
#         echo -e "\033[32m[成功]\033[0m $url - HTTP状态码: $http_code"
#     else
#         echo -e "\033[31m[失败]\033[0m $url - HTTP状态码: $http_code"
#     fi
# }

# # 主程序
# main() {
#     # 检查参数
#     if [ $# -eq 0 ]; then
#         echo "使用方法: $0 urls.txt"
#         echo "urls.txt 应包含每行一个URL"
#         exit 1
#     fi

#     # 检查文件是否存在
#     if [ ! -f "$1" ]; then
#         echo "错误: 文件 '$1' 不存在"
#         exit 1
#     fi

#     # 计数器
#     local total=0
#     local success=0
#     local failed=0

#     # 读取文件中的每个URL并检查
#     echo "开始检查URL..."
#     echo "------------------------"

#     while IFS= read -r url || [ -n "$url" ]; do
#         # 跳过空行和注释行
#         [[ -z "$url" || "$url" =~ ^#.*$ ]] && continue

#         ((total++))
#         check_url "$url"

#         if [ $? -eq 0 ]; then
#             ((success++))
#         else
#             ((failed++))
#         fi
#     done < "$1"

#     # 输出统计信息
#     echo "------------------------"
#     echo "检查完成!"
#     echo "总计: $total"
#     echo -e "\033[32m成功: $success\033[0m"
#     echo -e "\033[31m失败: $failed\033[0m"
# }

# # 运行主程序
# main "$@"

#!/bin/bash

# 检查并创建输出目录
init_output_dirs() {
  if [ ! -d "output" ]; then
    mkdir output
  fi
}

# 检查URL状态码的函数
check_url() {
  local url=$1
  local http_code
  local timestamp

  http_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')

  if [ "$http_code" = "200" ]; then
    echo -e "\033[32m[成功]\033[0m $url - HTTP状态码: $http_code"
    echo "[$timestamp] $url - HTTP状态码: $http_code" >>output/success.log
    return 0
  else
    echo -e "\033[31m[失败]\033[0m $url - HTTP状态码: $http_code"
    echo "[$timestamp] $url - HTTP状态码: $http_code" >>output/error.log
    return 1
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
  local success=0
  local failed=0

  # 清空之前的日志文件
  true >output/success.log
  true >output/error.log


  # 读取文件中的每个URL并检查
  echo "开始检查URL..."
  echo "------------------------"

  while IFS= read -r url || [ -n "$url" ]; do
    # 跳过空行和注释行
    [[ -z "$url" || "$url" =~ ^#.*$ ]] && continue

    ((total++))
    check_url "$url"

    if [ $? -eq 0 ]; then
      ((success++))
    else
      ((failed++))
    fi
  done <"$1"

  # 输出统计信息
  echo "------------------------"
  echo "检查完成!"
  echo "总计: $total"
  echo -e "\033[32m成功: $success\033[0m"
  echo -e "\033[31m失败: $failed\033[0m"
  echo "成功记录已保存到: output/success.log"
  echo "失败记录已保存到: output/error.log"
}

# 运行主程序
main "$@"
