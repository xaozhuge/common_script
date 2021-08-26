#!/bin/bash
detailtime=`date +%Y-%m-%d#%H:%M:%S`;
#查询进程对应的ID
pid=`ps aux|grep -v 'grep'|grep 'Canal/updateBinlogData'|awk '{print $2}'`;


if [ $pid ]; then
	kill -9 $pid
	echo $detailtime '---正在停止' >> /alidata/server/canal/client_bin/runtime.log;
else
	echo $detailtime '---未运行' >> /alidata/server/canal/client_bin/runtime.log;
fi

