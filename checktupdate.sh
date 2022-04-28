#/bin/bash
#1. 获取上次文件的更新时间
last_update_time=`cat tmp`
echo $last_update_time
file=package.json
#2. 获取当期文件的更新时间
update_time=`/usr/bin/stat -c %z $file`
echo $update_time

#3. 如果时间不相同，更新node_modules
if [ "$last_update_time"x == "$update_time"x ] ;then
	echo '时间相同，无内容更新';
else
	echo '时间不相同，有内容更新';
	/usr/bin/yarn 2>&1 | grep -iE 'yarn'
	echo $update_time >  tmp
fi
