#/bin/bash
#$1 是域名 $2是端口
#例如 /bin/bash checkport.sh baidu.com 80
res=`/usr/bin/nc -z -G 1 $1 $2 &> /dev/null && echo "Online" || echo "Offline"`
echo $1 $2 $res > /tmp/domain.log