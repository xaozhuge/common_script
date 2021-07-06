#!/bin/sh
#精确时间
detailtime=`date +%Y-%m-%d#%H:%M:%S`
#定义删除文件的目录
dir=/alidata/log
#定义修改时间n天以上的删除
daynum=30

#查找目录下N天以上的文件
for filename in `find $dir -mtime +$daynum -name '2021-06-*.log'`; do
	#输出日志
    echo $filename '##备份文件删除时间##'$detailtime >> $dir/delete.log
    #删除对应的文件
    #rm -f $filename
    du -sh $filename
done
