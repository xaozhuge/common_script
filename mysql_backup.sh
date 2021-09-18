#!/bin/sh
#备份时间
time=`date +%Y%m%d%H`
#精确时间
detailtime=`date +%Y-%m-%d#%H:%M:%S`
#本地名称
local_filename=$time.sql
#压缩后的名称 这里后缀为 .tar.gz
tar_filename=$time.tar.gz
cur_dir=$(cd "$(dirname "$0")"; pwd)
param_conf=$cur_dir/param_conf


#数据库名称
databasename=`cat $param_conf|grep 'database_name='|awk -F '=' '{print $2}'`
#备份文件路径
basepath=`cat $param_conf|grep 'database_backup_path='|awk -F '=' '{print $2}'`
#账号
username=`cat $param_conf|grep 'database_accout='|awk -F '=' '{print $2}'`
#密码
password=`cat $param_conf|grep 'database_password='|awk -F '=' '{print $2}'`
#定义修改时间n天以上的删除
daynum=`cat $param_conf|grep 'database_backup_days='|awk -F '=' '{print $2}'`


#备份数据库
/alidata/server/mysql/bin/mysqldump -u$username -p$password $databasename  > $basepath$local_filename 2>&1 | grep -v 'Using a password'

#前往备份目录,为了避免压缩携带目录
cd $basepath

#压缩文件
/usr/bin/tar -zcvf $tar_filename $local_filename 2>&1 | grep -v sql

#移除压缩前的文件
rm -f $basepath$local_filename

/usr/bin/du -sh $basepath$tar_filename


#查找目录下N天以上的文件
for filename in `find $basepath -mtime +$daynum -name '*.tar.gz'`; do
	#输出日志
    echo $filename '##备份文件删除时间##'$detailtime >> $basepath/delete.log
    #删除对应的文件
    #rm -f $filename
    du -sh $filename
done

#* */12 * * * /bin/sh /alidata/www/script.test.com/mysql_backup.sh  >> /alidata/backup/mysql/mysql_backup.log 2>&1