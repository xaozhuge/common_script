#/bin/bash
#查找满足某个目录下的文件
need_dir=Application/Runtime/Logs/Home
find_dir=/Users/peiwei/code
file_name=21_*log
for content in `sudo find $find_dir -name $file_name`; do
	# echo $content;
	if [[ $content == *$need_dir* ]] ;then
    	echo $content;
		rm -f $content;
	fi
done
