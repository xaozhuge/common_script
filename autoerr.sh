#!/bin/sh
detailtime=`date +%Y-%m-%d#%H:%M:%S`
log='/alidata/www/script.com/autoerr.log'
cd /alidata/log/php/fail;

for file in `ls|grep sql_err`; do
	/usr/bin/sed -i '/tikv restarts/d' $file;
	count=`cat $file|wc -l`
	if [ $count -eq 0 ]; then
		/usr/bin/rm -f $file
		echo $detailtime'-删除-'$file >> $log
	fi
done

for file in `ls|grep db_error`; do
	/usr/bin/sed -i '/Serialization failure/d' $file;
	count=`cat $file|wc -l`
	if [ $count -eq 0 ]; then
		/usr/bin/rm -f $file
		echo $detailtime'-删除-'$file >> $log
	fi
done
