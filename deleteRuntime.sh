#!/bin/sh
pre_path=/alidata/www/
filename=${pre_path}.git
runtime_path=${pre_path}Application/
log=${pre_path}codelog
detailtime=`date '+%Y-%m-%d %H:%M:%S'`

# 该日期格式不适用mac，适合centos7
lastmin=`date -d "1 minutes ago" "+%Y-%m-%d %H:%M"`
# 查看代码的更新时间
codetime=`stat -c %Y $filename`
codetime_format=`date '+%Y-%m-%d %H:%M' -d @$codetime`

if [ "$codetime_format" == "$lastmin" ]; then
	# sudo rm -rf ${runtime_path}Runtime/*
	echo $detailtime'-代码上线-删除'${runtime_path}Runtime >> $log
	exit;
fi



