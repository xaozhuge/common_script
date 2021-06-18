#!/bin/sh
#读取数据库配置文件
read username password <<< `cat /alidata/www/script.com/server.txt |grep localmysql|awk -F ':' '{print $2,$3}'`
#执行mysql语句
data=`
/usr/local/mysql/bin/mysql -u$username -p$password  -e \
"use zzz;
select url from desktop order by rand() desc limit 1;" \
2>&1 | grep -v 'Using a password'`
echo $data
