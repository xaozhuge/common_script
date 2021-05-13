#/bin/bash
#前往含有空格的目录
dstdir=~/Library/Application\ Support/Google
#不存在该目录
echo '结果一 如下'
ls $dstdir
echo '--------------------------------------------'

dstdir=~/Library/Application*Support/Google
#存在 Application Support 和 ApplicationSupport
echo '结果二 如下'
ls $dstdir
echo '--------------------------------------------'

dstdir=~/Library/Application?Support/Google
#可以实现
echo '结果三 如下'
ls $dstdir
echo '--------------------------------------------'

dstdir=~/Library/Application[[:space:]]Support/Google
#可以实现
echo '结果四 如下'
ls $dstdir
echo '--------------------------------------------'