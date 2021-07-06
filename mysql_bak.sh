#!/bin/sh
#备份时间
time=`date +%Y%m%d%H`
#备份数据库名称
databasename=zzz
#保存路径
basepath=/alidata/backup/mysql/
#本地名称
local_filename=$time.sql
#压缩后的名称 这里后缀为 .tar.gz
tar_filename=$time.tar.gz
#server.txt 格式化为 localmysql:username:password
read username password <<< `cat /alidata/www/script.com/server.txt |grep localmysql|awk -F ':' '{print $2,$3}'`
#备份数据库
/alidata/server/mysql/bin/mysqldump -u$username -p$password $databasename  > $basepath$local_filename 2>&1 | grep -v 'Using a password'
#前往备份目录,为了避免压缩携带目录
cd $basepath
#压缩文件
/usr/bin/tar -zcvf $tar_filename $local_filename 2>&1 | grep -v sql
#移除压缩前的文件
rm -f $basepath$local_filename
/usr/bin/du -sh $basepath$tar_filename


#精确时间
detailtime=`date +%Y-%m-%d#%H:%M:%S`
#定义删除文件的目录
dir=/alidata/backup/mysql/
#定义修改时间n天以上的删除
daynum=30

#查找目录下N天以上的文件
for filename in `find $dir -mtime +$daynum -name '*.tar.gz'`; do
	#输出日志
    echo $filename '##备份文件删除时间##'$detailtime >> $dir/delete.log
    #删除对应的文件
    #rm -f $filename
    du -sh $filename
done

#部署定时任务
#0 * * * * /bin/sh /alidata/www/script.com/mysql_bak.sh  >> /alidata/log/crontab/mysql_bak.log 2>&1

