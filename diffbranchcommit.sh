#!/bin/bash

#配置项目路径
dir=
#配置分支1/commit1
branchcommit1=
#配置分支2/commit2
branchcommit2=
#配置对比的目录，前端可设置为src
src=


#配置变更文件夹名称
changedir=changedir
#临时文件
delfile=$dir/changedelete

cd $dir;
#配置变更文件夹
mkdir -p $changedir;
echo '变更被删除的文件' > $delfile

#生成删除的文件
for deletefilename in `git diff  --name-only  --diff-filter=D $branchcommit1 $branchcommit2 $src`; do
	echo $deletefilename >> $delfile
done

#获取变更文件并移动到文件夹下
for filename in `git diff  --name-only $branchcommit1 $branchcommit2 $src`; do
	if [[ `cat $delfile|grep $filename` ]]; then
		continue;
	fi
	# #获取目录
	tmpdirname=`dirname $filename`
	# #获取文件名
	tmpfilename=`basename $filename`
	# #创建目录
	mkdir -p $changedir/$tmpdirname
	# #拷贝文件
	cp $filename $changedir/$tmpdirname/
done
