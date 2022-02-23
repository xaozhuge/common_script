#/bin/bash
#定义函数
removewarning(){
    grep -v '[Warning] Using a password on the command line interface can be insecure.'
}

#数据库名称
databases=$1
#数据表名称
tables=$2
#数据表文件保存路径
tableSqlPath=/tmp/table-$(date +%Y%m%d%H).sql


#server.txt 格式化为 localmysql:username1:password1
read username1 password1 <<< `cat server.txt |grep localmysql|awk -F ':' '{print $2,$3}'`
#server.txt 格式化为 remotemysql:username2:password2:ip2:port2
read username2 password2 ip2 port2 <<< `cat server.txt |grep remotemysql|awk -F ':' '{print $2,$3,$4,$5}'`

#sql文件初始化，切换数据库
echo 'use '${databases}';' > $tableSqlPath
#备份数据表
/usr/local/mysql/bin/mysqldump -h$ip2 -u$username2 -P$port2 -p$password2  $databases $tables >> $tableSqlPath 2>&1 | removewarning

#导入本地表
/usr/local/mysql/bin/mysql -u$username1 -p$password1 < $tableSqlPath
