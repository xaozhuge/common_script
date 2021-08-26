#!/bin/bash
detailtime=`date +%Y-%m-%d#%H:%M:%S`
#查询进程是否存在
alive=`ps aux|grep -v 'grep'|grep 'Canal/updateBinlogData'|wc -l`

if [ $alive -eq 0 ]
then
	nohup php_script.sh Canal updateBinlogData > /dev/null 2>&1 &
	echo $detailtime '---启动' >> /alidata/server/canal/client_bin/runtime.log
	exit
fi
echo $detailtime '---正在运行' >> /alidata/server/canal/client_bin/runtime.log
