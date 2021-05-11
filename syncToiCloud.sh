#/bin/bash
#定义函数
removewarning(){
    grep -v '[Warning] Using a password on the command line interface can be insecure.'
}
#备份时间
time=`date +%Y%m%d%H`
#备份数据库名称
databasename=zzz
#保存路径
basepath=/Users/peiwei/temp/
#本地名称
local_filename=$time.sql
#压缩后的名称
tar_filename=$time.zip
#server.txt 格式化为 localmysql:username:password
read username password <<< `cat server.txt |grep localmysql|awk -F ':' '{print $2,$3}'`
#备份数据库
/usr/local/mysql/bin/mysqldump -u$username -p$password $databasename  > $basepath$local_filename 2>&1 | removewarning
#压缩文件
/usr/bin/zip -jr $basepath$tar_filename $basepath$local_filename 2>&1 | grep -v deflated
#移除压缩前的文件
rm -f $basepath$local_filename
#移动到icloud目录
/bin/mv $basepath$tar_filename /Users/peiwei/Library/Mobile\ Documents/com~apple~CloudDocs
du -sh /Users/peiwei/Library/Mobile\ Documents/com~apple~CloudDocs/$tar_filename
