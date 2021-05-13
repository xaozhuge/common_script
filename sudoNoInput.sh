#/bin/bash
#当前脚本的绝对路径
current=$(cd "$(dirname "$0")";pwd)
#server.txt 和 当前脚本处在同一路径 格式为 sudopass:密码
read pass <<< `cat $current/server.txt |grep sudopass|awk -F ':' '{print $2}'`
echo $pass | sudo -S echo '********'
sudo pwd
