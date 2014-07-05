  
#!/usr/bin/bash
#backupfiles
#逐个文件夹递归备份文件
#输入为一个或多个文件、文件夹
    
hmdir="$HOME"
bkdir="${HOME}/backup"
dt=$(date +%Y%m%d)
tm=$(date +%H%M%S)
crtdir=$(pwd)
dtdir=${bkdir}${crtdir:${#hmdir}}
    
function usage()
{
    echo "usage: backup file(s) dir(s)"
    exit 0
}

function bkfile()
{
    #$1=crtdir
    #$2=destdir
    #$3=file
        
    mkdir -p $2
    if [ -f $2/$3 ];then
        cmp -s $2/$3 $1/$3
        [ $? -eq 1 ] && cp $2/$3 $2/$3.${tm}
    fi
    cp $1/$3 $2
}

function bkdir()
{
    local ctdir dtdir dtfiles
    ctdir=$1
    shift
    dtdir=$1
    shift
    dtfiles=$*
        
    for file in ${dtfiles};do
        [ -f ${ctdir}/${file} ] && bkfile $ctdir ${dtdir}/${dt} $file
        if [ -d ${ctdir}/${file} ];then
            nctdir=${ctdir}/$file
            ndtdir=${dtdir}/$file
            vars=$(ls $nctdir)
            bkdir $nctdir $ndtdir $vars
        fi
    done
}

function bk()
{
    while [ $# -gt 0 ]
    do
        [ -f "$1" ] && bkfile $crtdir ${dtdir}/${dt} $1
        [ -d "$1" ] && bkdir ${crtdir}/$1 ${dtdir}/$1 $(ls $1)
        shift
    done
}
    
[ $# -eq 0 ] && usage || bk $*