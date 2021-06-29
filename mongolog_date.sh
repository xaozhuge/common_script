#!/bin/sh
#读取账号和密码
read username password <<< `cat /tencentdata/www/script.qimingpian.com/server.txt |grep mongodb|awk -F ':' '{print $2,$3}'`
#认证 => logRotate
/usr/local/kencery/mongoDB/mongodb/bin/mongo 127.0.0.1:27017/admin --eval "db.auth('$username','$password');db.runCommand({logRotate:1});"
