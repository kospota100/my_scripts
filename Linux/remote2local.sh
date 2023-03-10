#!/bin/sh

if [ $1 = "help" ]; then

        echo "\n\t======= remote2local use manual =======\n"
        echo "  Usage:"
        echo "    sh remote2local.sh [Option] [Remote file/folder] [Remote username] [Remote IP addr] [Remote port]\n"
        echo "  Option:"
        echo "    help  show usage manual"  
        echo "    -e    execute"

        echo ""

elif [ $1 = "-e" ]; then

        echo "\nCopy remote machine $3@$4:$2 port $5 to local dir ~/remote/\n"

        rsync -avzh -e "ssh -p ${5}" --progress --protect-args "$3@$4:$2" ~/remote/

fi
