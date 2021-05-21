#!/bin/bash
nowtime=`date +%Y-%m-%d/%H:%M:%S`
interface=eth1
numtime=5
logpath=/home/zzz/bandwidth.log

 (/usr/sbin/iftop -o 2s -tnN -s $numtime -i $interface -L 4096 2>&1 | egrep "=>|<="\
| awk '{ if ($3 == "=>") {print $2" "$3" "$4} else {print $1" "$2" "$3}}') | xargs -l2 | awk '{print $3,$1,$2,$4":"$6,$1,$5,$4}' | awk -F ":" '{for(i=1;i<=NF;i++) print $i}' > /tmp/tmp.log

echo  >> $logpath
echo $nowtime >> $logpath
echo '出网带宽' >> $logpath
cat /tmp/tmp.log|grep '=>' >> $logpath
echo '入网带宽' >> $logpath
cat /tmp/tmp.log|grep '<=' >> $logpath
echo  >> $logpath
