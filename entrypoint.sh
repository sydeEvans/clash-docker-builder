#!/bin/bash

curl -o /home/runner/.config/clash/config.yaml "$SUB_URL"

# 允许局域网链接
sed -i 's/allow-lan: false/allow-lan: true/g' /home/runner/.config/clash/config.yaml

echo '###################'
echo 'update /home/runner/.config/clash/config.yaml file'
echo '###################'

# 原始脚本！！！
# 脚本执行失败时脚本终止执行
set -o errexit
# 遇到未声明变量时脚本终止执行
set -o nounset
# 执行管道命令时，只要有一个子命令失败，则脚本终止执行
set -o pipefail
# 打印执行过程
set -o xtrace

#===========================================================================================
# TimeZone Configuration
#===========================================================================================
if [ -v TZ ]; then
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi

#===========================================================================================
# Grant Permissions
#
# 1. /workspace: 工作目录
# 1. /home/runner: 用户目录
#===========================================================================================
set +o errexit
find . \! -user runner -exec chown runner:runner '{}' +
find /home/runner \! -user runner -exec chown runner:runner '{}' +
set -o errexit

#===========================================================================================
# Run Nginx
#===========================================================================================
nginx

#===========================================================================================
# Run
#===========================================================================================
if [ "$#" == "0" ]; then
    # 用户没有输入命令，则启动 clash
    exec gosu runner clash -d /home/runner/.config/clash
else
    # 以 runner 用户运行开发者指定的命令
    exec gosu runner "$@"
fi