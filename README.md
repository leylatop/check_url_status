# 检查URL返回的状态码

## 功能
1. 从文件中读取URL列表
2. 使用curl检查每个URL的HTTP状态码
3. 输出检查结果

## 特点
- 支持检查任何类型的URL资源
- 使用颜色输出,便于识别结果
- 提供总体统计信息
- 跳过空行和注释行
- 错误处理和参数检查
- 简单的使用说明
- 输出日志文件


## 使用
1. 将URL列表保存到urls.txt文件中
2. 给脚本添加执行权限: `chmod +x check_urls.sh`
3. 运行脚本: `./check_urls.sh urls.txt`
4. 查看输出结果和日志文件

## 安装
1. 使用npm安装: `npm install -g check-urls-cli`
2. 本地安装: 
   1. git clone 下载代码
   2. 给安装脚本添加执行权限：`chmod +x install.sh`
   3. 运行安装脚本：`sudo ./install.sh`
4. 安装完成后，你可以在系统任何位置使用以下命令：`check-urls urls.txt`

## 卸载
1. 使用npm卸载: `npm uninstall -g check-urls-cli`
2. 本地卸载: 
   1. 给卸载脚本添加执行权限：`chmod +x uninstall.sh`
   2. 运行卸载脚本：`sudo ./uninstall.sh`
   3. 删除全局执行文件：`rm -rf /usr/local/bin/check-urls`
