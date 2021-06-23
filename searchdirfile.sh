#!/bin/sh
current=$(cd "$(dirname "$0")";pwd)
read passwd <<< `cat $current/server.txt |grep sudopass|awk -F ':' '{print $2}'`
rootdir=/
if [ "$1" = "" ]; then
  echo '未提供搜索关键字';
  exit;
fi

echo $passwd | sudo -S echo "搜索开始"

#搜索文件
for content in `sudo find $rootdir -type f -iname "*${1}*" 2>&1 | grep -v 'find'`; do
	if [ "$file_title" = "" ]; then
  	echo "搜索到的文件如下:"
	fi
	file_title=1;
	echo $content;
done

#搜索目录
for content in `sudo find $rootdir -type d -iname "*${1}*" 2>&1 | grep -v 'find'`; do
	if [ "$dir_title" = "" ]; then
  	echo "搜索到的目录如下:"
	fi
	dir_title=1;
	echo $content;
done


