#!/bin/sh
#pkpacman.sh
#简单的pacman命令的封装

usage()
{
	echo "usage:ms [options] [targets]" 
	echo  -e "  -i\t安装软件"
	echo  -e "  -s\t查询软件"
	echo  -e "  -r\t删除软件"
	echo  -e "  -u\t更新系统"
	echo  -e "  -c\t清除缓存"
	echo  -e "  -g\t孤立软件"
	echo  -e "  -x\t软件信息"
	exit 0
}

[ "$#" -lt "1" ] && usage && exit 1

opts=$1
shift
case ${opts} in
    -i|i) sudo pacman -S $* ;;
    -s|s) sudo pacman -Ss $* || sudo pacman -Qs $* ;;
    -r|r) sudo pacman -Rns $* ;;
    -u|u) sudo pacman -Syu ;;
    -c|c) sudo pacman -Scc $* ;;
    -g|g) sudo pacman -Qdt $* ;;
    -x|x) sudo pacman -Si $* || sudo pacman -Qi $* ;;
       *) usage ;;
esac           
