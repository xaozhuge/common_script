#! /bin/bash

#暂定60s完成打包
limit=60
#循环到59
unfinish=59
detailtime=`date +%Y%m%d%H%M`

progress_bar()
{
    RET=`echo $2*100/$1|bc`
    BLACK=""
    for ((m = 1; $m <= $RET; m++))
        do
            BLACK="$BLACK#"
        done
    printf "[%-100s]%02d%%\r" $BLACK $RET
}

echo '' > /tmp/temp
echo '' > /tmp/packlog

{
	sleep 50; #脚本代码
	echo '1' > /tmp/temp
}& # 把循环体放入后台运行，相当于是起一个独立的线程，在这里是异步脚本

echo '打包进度'

for ((i = 1; $i <= $unfinish; i++))
do
	res=`cat /tmp/temp`
	if [[ $res -eq '1' ]]; then
		i=$limit
	fi
	progress_bar $limit $i
	sleep 1
done

wait # wait命令的意思是，等待（wait命令）上面的命令（放入后台的）都执行完毕了再往下执行，通常可以和&搭配使用

res=`cat /tmp/temp`
if [[ $res -eq '1' ]]; then
	progress_bar $limit $limit
fi
echo ''
echo '打包完成'

cat /tmp/packlog